HOSTNAME=$1
PPORT=$2

psql -Xq -d postgres  -U postgres  -h $HOSTNAME  -p $PPORT  <<eom
      DROP  DATABASE ts  WITH (FORCE);
      CREATE DATABASE ts OWNER prometheus;
eom

psql -1Xq -d ts -U postgres -h $HOSTNAME -p $PPORT <<eom
      CREATE EXTENSION IF NOT EXISTS pg_stat_statements ;
eom

psql -1Xq -d ts -U postgres -h $HOSTNAME -p $PPORT <<eom
      CREATE EXTENSION IF NOT EXISTS dblink;
      CREATE EXTENSION IF NOT EXISTS pgbouncer_fdw;

      DROP SERVER IF EXISTS pgbouncer CASCADE;
      CREATE SERVER pgbouncer FOREIGN DATA WRAPPER dblink_fdw OPTIONS (host 'localhost',
                                                                 port '6432',
                                                                 dbname 'pgbouncer');
      CREATE USER MAPPING FOR prometheus SERVER pgbouncer OPTIONS (user 'postgres', password 'silver');
eom
