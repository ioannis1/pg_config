HOSTNAME=$1
PPORT=$2

psql -Xq -d postgres -U postgres  -h $HOSTNAME -p $PPORT  <<eom

      CREATE EXTENSION IF NOT EXISTS sslinfo ;
eom

