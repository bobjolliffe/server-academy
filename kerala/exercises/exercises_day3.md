# Kerala server academy

## Exercises Day 3 - Postgres

Postgresql configuration is done through text files in
/etc/postgresql/<version>/main directory.

The two most important configuration files are postgresql.conf
and pg_hba.conf.

### pg_hba.conf Access control

For an all-in-one DHIS2 installation (with everything on the same machine)
the default settings are good and don't need to be adjusted.

If you need to make your database accessable from another machine, then 
access controls need to be adjusted.  Good practice here is always to allow
only the minimum access to get the job done.

Settings in the pg_hba.conf file are described in the postgresql online documentation
[here](https://www.postgresql.org/docs/9.6/static/auth-pg-hba-conf.html).

Work through an exercise where one linode allows dhis2 database access from another linode.

### postgresql.conf Tuning
This section requires we download the demo database from [here](https://s3-eu-west-1.amazonaws.com/databases.dhis2.org/sierra-leone/2.28/dhis2-db-sierra-leone.sql.gz).

Relevant documentation:
[DHIS2 documentation](https://docs.dhis2.org/2.29/en/implementer/html/install_server_setup.html#install_postgresql_performance_tuning)

[Postgresql documentation](https://www.postgresql.org/docs/9.5/static/config-setting.html)

Discuss tuning options.


