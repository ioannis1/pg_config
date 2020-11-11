HOSTNAME=$1
PPORT=$2
MONITOR_USER=prometheus 

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
                                                                 port '6543',
                                                                 dbname 'pgbouncer');
      CREATE USER MAPPING FOR $MONITOR_USER  SERVER pgbouncer OPTIONS (user 'postgres', password 'secret');
eom
psql -1Xq -d ts -U postgres -h $HOSTNAME -p $PPORT <<eom
       GRANT USAGE ON FOREIGN SERVER pgbouncer TO $MONITOR_USER ;

       GRANT SELECT ON pgbouncer_clients      TO  $MONITOR_USER ;
       GRANT SELECT ON pgbouncer_config       TO  $MONITOR_USER ;
       GRANT SELECT ON pgbouncer_databases    TO  $MONITOR_USER ;
       GRANT SELECT ON pgbouncer_dns_hosts    TO  $MONITOR_USER ;
       GRANT SELECT ON pgbouncer_dns_zones    TO  $MONITOR_USER ;
       GRANT SELECT ON pgbouncer_lists        TO  $MONITOR_USER ;
       GRANT SELECT ON pgbouncer_pools        TO  $MONITOR_USER ;
       GRANT SELECT ON pgbouncer_servers      TO  $MONITOR_USER ;
       GRANT SELECT ON pgbouncer_sockets      TO  $MONITOR_USER ;
       GRANT SELECT ON pgbouncer_stats        TO  $MONITOR_USER ;
       GRANT SELECT ON pgbouncer_users        TO  $MONITOR_USER ;
eom
