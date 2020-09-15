HOSTNAME=$1
PPORT=$2

psql -Xq -d template1 -U postgres  -h $HOSTNAME -p $PPORT  <<eom

      CREATE EXTENSION IF NOT EXISTS plpgsql ;
eom

