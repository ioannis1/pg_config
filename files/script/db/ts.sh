psql -Xq postgres  postgres <<eom
      DROP  DATABASE ts  WITH (FORCE);
      CREATE DATABASE ts OWNER prometheus;
eom

#psql -1Xq -d ts -U postgres <<eom
      #CREATE EXTENSION IF NOT EXISTS pgtap ;
#eom

