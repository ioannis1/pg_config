Role ioannis1.pg_config
=========

Configure a postgres cluster that is already running, and ensures roles 'postgre', 'ioannis', and 'nagios' exist and can connect via md5 authendication. Passwords for  role 'postgres' is (optionally) configurable, passwords for the other roles are hardcoded. Some databases and privs are created and set along with some extensions. Cluster configuration
files are left untouched.


Requirements
------------

 Assumptions:
    - postmaster  is not running
    - ansible executes as unix user 'postgres'
    - cluster has been initialized and pg_hda allows role 'postres'to connect
    - we will not configure osx hosts because psycopg2 might be hard to install through macports

 Post conditions:
   - postmaster might be running, depending on variable  "run_cluser" in ../default/meta.yml
   - pg_hba.conf is updated
   - created postgres roles with passwords
   - added to template1
   - created  databases, extensions, languages, and set privs
   - enabled replication via uses 'postgres' and 'replication' (see pg_hba.conf)


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

