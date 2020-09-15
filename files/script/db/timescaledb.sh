psql -Xq postgres  postgres <<eom
      DROP  DATABASE   timescaledb  WITH (FORCE);
      CREATE DATABASE timescaledb OWNER prometheus;
eom

#psql -1Xq -d timescaledb -U postgres <<eom
      #CREATE EXTENSION IF NOT EXISTS pgtap ;
#eom

