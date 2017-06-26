# Kigali server academy

## Exercises Day 2

### Catching up from day 3:

1. Complete postfix installation
2. dhis2-tools overview and exercises from day1

### Nginx ssl
To get an A+ ...

Generate DH parameters as like this.  It will take a long time to run.
```
cd /etc/ssl/certs
openssl dhparam -out dhparam.pem 4096
```
Apply setting in nginx configuration file:
```
ssl_dhparam /etc/ssl/certs/dhparam.pem;
```
Apply other ssl parameters from dhis2-tools [sample](https://github.com/dhis2/dhis2-tools/blob/master/src/pkg/usr/share/dhis2-tools/samples/nginx/dhis2).

```
# ssl stuff
  ssl                  on;
  ssl_certificate      /etc/ssl/certs/ssl-cert-snakeoil.pem;
  ssl_certificate_key  /etc/ssl/private/ssl-cert-snakeoil.key;
  ssl_session_timeout  30m;
  ssl_protocols              TLSv1 TLSv1.1 TLSv1.2;
  ssl_session_cache shared:SSL:10m;
  ssl_prefer_server_ciphers  on;
  
  # This is quite strict.  If you have much older windoze browsers
  # to support you might need the line below instead.
  ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';

  # ssl_ciphers "ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES128-SHA256:DHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES256-GCM-SHA384:AES128-GCM-SHA256:AES256-SHA256:AES128-SHA256:AES256-SHA:AES128-SHA:DES-CBC3-SHA:HIGH:!aNULL:!eNULL:!EXPORT:!DES:!MD5:!PSK:!RC4";

  # Enable HSTS
  add_header Strict-Transport-Security max-age=63072000;

  # Do not allow this site to be displayed in iframes
  add_header X-Frame-Options DENY;

  # Do not permit Content-Type sniffing.
  add_header X-Content-Type-Options nosniff;

  # You need to generate the dh parameters before using this setting
  # Command:  openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
  # ssl_dhparam /etc/ssl/certs/dhparam.pem;
```



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

**Exercise:**  Working with a neighbouring team, use Ghana backup script to push copy of backup files to remote backup server.

**Exercise:**  Working with neighbouring team(s), implement streaming replication according to [manual](https://docs.dhis2.org/2.26/en/implementer/html/install_read_replica_configuration.html).
Reference: https://www.postgresql.org/docs/9.5/static/high-availability.html

**Exercise:**  Working with neighbouring team(s) work out a set of benchmarking guidelines for postgres tuning

**Exercise:** Get letsencrypt working and document
