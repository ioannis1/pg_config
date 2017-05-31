Role ioannis1.pg_config
=========

Configure a runnning postgres cluster. Ensures roles 'postgres', 'ioannis', and 'nagios' exist and can connect via md5 authendication. Password for  role 'postgres' is (optionally) configurable, passwords for other roles are hardcoded. Some databases and privs are created and set along with some extensions.  A new pg_hba.conf is installed, other configuration files are left untouched. 


Requirements
------------
 Needs python's psycopg2 . The relevant package is installed if needed for the relevant platformes that this
role supports; if yours is not supported, you will need to install psycopg2 yourself before using this role.

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

Shown bellow are variables with their default values:

cluster:             ~/postges/green
pport:               5434
postgres_passwd:     silver
keep_running:        False

where,
'cluster'           Unix directory that contains the postgres $PGDATA. 
'pport'             Port where postgres accepts connection (note the double 'p' in pport).
'postgres_passwd'   Password for role postgres needed to login to the database and make changes. Even
                    if old auth method was 'trust', this password with be used to set the new
                    password for the role postgres using md5 authentication, thus, old and new passwords 
                    remain identical.
'keep_running'      Whether to keep the server running after configuration has finished. 



Dependencies
------------

None. Though role 'ioannis1.pg_initdb', or any third-party role,  could be used to initialize the postgres cluster 
since prior initizlization is assumed.

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: ioannis1.pg_config, cluster: "~postgres/green", postgres_passwd="silver", keep_running: true }


License
-------

BSD

Author Information
------------------
Ioannis Tambouras <ioannis@akroninc.net>

