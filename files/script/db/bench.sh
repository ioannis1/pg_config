HOSTNAME=$1
PPORT=$2

psql -Xq -d postgres  -U postgres  -h $HOSTNAME  -p $PPORT  <<eom
      DROP  DATABASE bench  WITH (FORCE);
      CREATE DATABASE bench OWNER ioannis;
eom


