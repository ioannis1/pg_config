Role ioannis1.pg_config
=========

Configure a running postgres cluster. Ensures roles 'postgres', 'ioannis', and 'nagios' exist and can connect via md5 authendication. Password for  role 'postgres' is (optionally) configurable, passwords for other roles are hardcoded. Some databases and privs are created and set along with some extensions.  A new pg_hba.conf is installed, other configuration files are left untouched. 


Requirements
------------
 Needs python's psycopg2 . The relevant package is installed if needed for the relevant platforms that this
role supports; if yours is not supported, you will need to install psycopg2 yourself before using this role.

 Assumptions:
    - postmaster is already running; otherwise, an attempt will be  made to start it.
    - Ansible executes as unix user 'postgres'
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

cluster:             ~/postgres/green
pport:               5434
postgres_passwd:     No default exists for this variable. 
repl_and_pg_roles:   True
keep_running:        True

where,

cluster             The Unix $PGDATA directory.
pport               Port where postgres accepts connection (note the double 'p' in pport).
postgres_passwd     Password for role postgres needed to login to the database and make changes. If this
                    variable is not provided, it is expected that the auth method for the cluster is either 'trust'
                    or user 'postgres' is able to successfully login without password, if not, no modifictions are 
                    possible and tasks will soon fail.
repl_and_pg_roles   Adds postgres users 'postgres' and 'replication' so they don't have to be included
                    using the 'users' list. But you could include them twice if you which, in which case,
                    the definitions of these two users inside the 'users' list takes precedence. This option
                    assingns the same password for both users 'postgres' and 'replication'  to the value
                    spesified by the  'postgress_passwd' variable; if this variable was not provided, any
                    existings definitions for these two users remain intact and this option has no effect.
                   
keep_running       Whether to keep the server running after configuration has finished. Say 'False' to shutdown
                   postmaster.

users              A list of hashes, where each hash contains one or more of these keys: 'name', 'passwd', 'attr'.
                   (See example playbook bellow.) 


Dependencies
------------

None. Though role 'ioannis1.pg_initdb', or any third-party role,  could be used to initialize the postgres cluster 
since prior initialization is assumed.

Example Playbook
----------------

    - hosts: servers
      vars:
         users:
            - { name: ioannis,     passwd: apple,  attr: createdb    }
            - { name: nagios,      passwd: orange                    }
      roles:
         - { role: ioannis1.pg_config, cluster: "~postgres/green", postgres_passwd="apple", pport: 5432 }



License
-------

BSD

Author Information
------------------
Ioannis Tambouras <ioannis@akroninc.net>

