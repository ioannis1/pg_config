Role ioannis1.pg_config
=========

Configure a runnning postgres cluster. Ensures roles 'postgres', 'ioannis', and 'nagios' exist and can connect via md5 authendication. Password for  role 'postgres' is (optionally) configurable, passwords for other roles are hardcoded. Some databases and privs are created and set along with some extensions.  A new pg_hba.conf is installed, other configuration files are left untouched. 


Requirements
------------
 Needs python's psycopg2 . The relevant package is installed if needed for the relevant platformes that this
role supports; if yours is not supported, you will need to install psycopg2 yourself before using the this role.

 Assumptions:
    - postmaster is already running; otherwise, an attempt will be  made to start it.
    - ansible executes as unix user 'postgres'
    - cluster has been initialized and pg_hda.conf permits role 'postgres' to connect

 Post conditions:
   - postmaster might be left running, depending on variable  "run_cluser" in ../default/meta.yml
   - pg_hba.conf is updated
   - created postgres roles with passwords
   - created 'replication' role with password
   - added plpgsql to template1
   - created  databases, extensions, languages, and set privs
   - enabled replication for roles 'postgres' and 'replication' (see pg_hba.conf)


Role Variables
--------------

cluster:             ~/postges/green
pport:               5434
postgres_passwd:     silver
keep_running:        False

Shown above are variables with their default values
where,
'cluster'           is  the unix directory that contains the postgres $PGDATA. 
'pport'             is  the port where postgres accepts connection.
'postgres_passwrd'  for md5 authentication for role 'postgres'. Non needed if method is  'trust' . 
'keep_running'      is  whether to keep the server running after configuration has finished. 



Dependencies
------------

None. Roles 'pg_initdb' could be used to initialize the postgres cluster since such initizlization is a pre-condition .

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------
Ioannis Tambouras <ioannis@akroninc.net>

