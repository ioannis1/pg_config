psql -Xq postgres  postgres <<eom
      DROP  DATABASE ioannis   WITH ( FORCE );
      CREATE DATABASE ioannis OWNER ioannis;
eom

psql -Xq -d ioannis -U postgres <<eom
      CREATE EXTENSION IF NOT EXISTS pgtap ;
eom

