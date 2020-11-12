HOSTNAME=$1
PPORT=$2
PASSWD=$3
MONITOR_USER=prometheus 

psql -Xq -d postgres  -U postgres  -h $HOSTNAME  -p $PPORT  <<eom
      DROP  DATABASE ts  WITH (FORCE);
      CREATE DATABASE ts OWNER prometheus;
eom

psql -1Xq -d ts -U postgres -h $HOSTNAME -p $PPORT <<eom
      CREATE EXTENSION IF NOT EXISTS pg_stat_statements ;
eom

psql -1Xq -d ts -U postgres -h $HOSTNAME -p $PPORT -v passwd="'$PASSWD'" -v muser=${MONITOR_USER} <<eom
      CREATE EXTENSION IF NOT EXISTS dblink;
      CREATE EXTENSION IF NOT EXISTS pgbouncer_fdw;

      DROP SERVER IF EXISTS pgbouncer CASCADE;
      CREATE SERVER pgbouncer FOREIGN DATA WRAPPER dblink_fdw OPTIONS (host 'localhost',
                                                                 port '6543',
                                                                 dbname 'pgbouncer');
      CREATE USER MAPPING FOR :muser  SERVER pgbouncer OPTIONS (user 'postgres', password :passwd );
eom

psql -1Xq -d ts -U postgres -h $HOSTNAME -p $PPORT -v muser=${MONITOR_USER} <<eom
       GRANT USAGE ON FOREIGN SERVER pgbouncer TO $MONITOR_USER ;

       GRANT SELECT ON pgbouncer_clients      TO  :muser ;
       GRANT SELECT ON pgbouncer_config       TO  :muser ;
       GRANT SELECT ON pgbouncer_databases    TO  :muser ;
       GRANT SELECT ON pgbouncer_dns_hosts    TO  :muser ;
       GRANT SELECT ON pgbouncer_dns_zones    TO  :muser ;
       GRANT SELECT ON pgbouncer_lists        TO  :muser ;
       GRANT SELECT ON pgbouncer_pools        TO  :muser ;
       GRANT SELECT ON pgbouncer_servers      TO  :muser ;
       GRANT SELECT ON pgbouncer_sockets      TO  :muser ;
       GRANT SELECT ON pgbouncer_stats        TO  :muser ;
       GRANT SELECT ON pgbouncer_users        TO  :muser ;
eom
