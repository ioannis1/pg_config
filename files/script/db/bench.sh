psql -Xq postgres  postgres <<eom
      DROP  DATABASE bench  WITH (FORCE);
      CREATE DATABASE bench OWNER ioannis;
eom


