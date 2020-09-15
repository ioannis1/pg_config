#/dist-pg/bin/psql -1Xq postgres postgres <<eom
psql -1Xq postgres postgres <<eom


DROP ROLE  IF EXISTS  ioannis       ;
DROP ROLE  IF EXISTS  prometheus    ;
DROP ROLE  IF EXISTS  read_only     ;
DROP ROLE  IF EXISTS  replication   ;


ALTER ROLE postgres password 'silver';

CREATE USER  ioannis       password    'silver';
CREATE USER  prometheus    password    'silver';
CREATE USER  read_only     password    'silver';
CREATE USER  replication   password    'silver';

eom

