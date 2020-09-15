#/dist-pg/bin/psql -1Xq postgres postgres <<eom
HOSTNAME=$1
PPORT=$2

psql -Xq -d postgres -U postgres -h $HOSTNAME -p $PPORT  <<eom




ALTER ROLE postgres password 'silver';

DROP ROLE  IF EXISTS  ioannis                      ;
CREATE USER  ioannis                               ;   
ALTER ROLE ioannis  CREATEDB  password    'silver' ;

DROP ROLE  IF EXISTS  prometheus              ;
CREATE USER  prometheus                       ;   
ALTER  ROLE  prometheus  password    'silver' ;

DROP ROLE  IF EXISTS  read_only               ;
CREATE USER  read_only                        ; 
ALTER ROLE   read_only  password    'silver'  ;

DROP ROLE  IF EXISTS  replication            ;
CREATE USER  replication                     ; 
ALTER ROLE replication  password    'silver' ;

eom

