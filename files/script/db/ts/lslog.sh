HOSTNAME=$1
PPORT=$2

psql -Xq -d ts  -U postgres  -h $HOSTNAME  -p $PPORT  <<eom

CREATE SCHEMA IF NOT EXISTS pgexporter AUTHORIZATION prometheus;
GRANT USAGE ON SCHEMA pgexporter TO prometheus;

SET SEARCH_PATH  to pgexporter;



CREATE OR REPLACE FUNCTION ls_logdir( ) RETURNS numeric AS
\$\$ SELECT sum( (i).size)  FROM pg_catalog.pg_ls_logdir() as i; \$\$
LANGUAGE sql
VOLATILE
SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION ls_logdir()  TO prometheus;

eom

