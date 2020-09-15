HOSTNAME=$1
PPORT=$2

psql -Xq -d postgres  -U postgres  -h $HOSTNAME  -p $PPORT  <<eom
      DROP  DATABASE ioannis   WITH ( FORCE );
      CREATE DATABASE ioannis OWNER ioannis;
eom

psql -Xq -d ioannis -U postgres <<eom
      CREATE EXTENSION IF NOT EXISTS pgtap ;
eom

