# Kigali server academy

## Exercises Day 2

### Catching up from day 1:

1. Complete postfix installation
2. dhis2-tools overview and exercises from day1

###  Daily dose of unix
(short presentation)

Demo of rsync and tar commands

###  ssh tips and tricks
1.  Automatic remote login with keys.
2.  Execute remote commands through pipeline
3.  ssh tunnel.  Examples:
3.1  ataching to remote postgres server with pgadmin
3.2  jmx performance monitoring

**Exercise:**  Working with a neighbouring team, modify dhis2-tools backup script to push copy of backup files to remote backup server.

###  Network basics
(short pres)

###  Postgres configuration
1.  Review the settings in [manual](https://docs.dhis2.org/master/en/implementer/html/install_server_setup.html#install_setting_server_tz).
TIP:  postgresql settings at the bottom of the file override what appears at the top.  So make all your adjustments at the bottom, or `include` a custom settings file.

Also review postgres [wiki](https://wiki.postgresql.org/wiki/Tuning_Your_PostgreSQL_Server).

2.  pgbench can give you a rough idea of a baseline performance to see if performance tweaks are making an impact.  eg.
```
createdb test
pgbench -i test
pgbench -T 60 -c 30 test
```
Note that pgbench can be customised to simulate different types of loads and queries.

3.  Postgres backups
The problem with -O
Encrypting backup files (the example from ghana)
