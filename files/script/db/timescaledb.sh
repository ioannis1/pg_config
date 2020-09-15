HOSTNAME=$1
PPORT=$2

psql -Xq -d postgres  -U postgres  -h $HOSTNAME  -p $PPORT  <<eom
      DROP  DATABASE   timescaledb  WITH (FORCE);
      CREATE DATABASE timescaledb OWNER prometheus;
eom

#psql -1Xq -d timescaledb -U postgres -h $HOSTNAME -p $PPORT  <<eom
      #CREATE EXTENSION IF NOT EXISTS pgtap ;
#eom

