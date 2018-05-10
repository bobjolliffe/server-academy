# Kerala server academy

## Catching up on things we missed
1.  Setting up mail
2.  Country presentations (Nepal, ...)
3.  Upgrading dhis2 war file
4.  Backups
5.  Encrypted at rest data (tomorrow)
6.  Automating certbot renewal

## Major Upgrade process
0. might need to remove custom views
1. inform users
2. shutdown tomcat
3. backup database
4. keep a copy of old war file
5. Read upgrade notes / release notes
6. Download and run any required sql files
7. Wipe out old webapps directory and replace with new war file (or run dhis2-deploy-war)
8. start tomcat
(note: new dhis2-tools will not allow tomcat permission to explode war)

## Server Academy Projects

The following is a short list of suggested projects, graded by difficulty.  To get the most out of these you should select projects which (i) suit your level of experience and (ii) address some real problem you have in your environment.

## For the less experienced
### Practice install process
We have gone through the installation of dhis2 with apache2 and exim4 once or twice quite quickly.  It is a good exercise to repeat this process yourself once or twice so that you feel comfortable with the process.  Make a note of any issues you encounter or suggestions for improvement which you can present back to the group.

### Practice upgrade
Deploy 2.28 war file and sample database.  Upgrade to 2.29 war file (apply sql upgrade script first).

### Creating a backend user
It is a common challenge to create a new user on the system.  You do not want to exchange the password for the new user by email.  Get a fellow participant to send you a username and ssh public key by email.  Create the new user with ssh access and leave her password in a protected file in her home directory.  Test.  As an additional challenge, can you write a script to make this job easier?

## Slightly harder
### Database backups
You will need to work with another team for this exercise as you need access to two linodes (one as the designated archive server).  In the `resources` folder there is a script for automating and encrypting backups.  Configure this script to backup and encrypt your databases and ship them to the archive server.

Variations:
1.  Can you configure this to go the other way ie. the archive server pulls the backups rather pushing to the archive server.
2.  Restoration.  You only know you have good backups if you have tested restoring them.  Write a script to fetch encrypted backups from the archive server and test restore.  Send alert if there is an error.

openssl aes-256-cbc -d -pass file:passwd.pg -salt -in backups/backup2018-05-10-daily/dhis.sql.gz.enc | gunzip -  > decrypted_backup.sql

## Analytics performance benchmarking
Experiment with running analytics against the demo database, tuning different postgresql parameters to come up with the best result.

## nginx conf file
We have been working with apache2 as a proxy server.  Create a really good(!!) nginx conf file to distribute with dhis2-tools.

## Experienced sysadmins

### Containerize everything
Install lxd and create 3 containers - one each for proxy, database and instances.  Configure iptables to forward ports 80/443 to proxy container.

### Load balancing

Check [here](https://docs.dhis2.org/2.29/en/implementer/html/install_web_server_cluster_configuration.html).

### Database replication
See [DHIS2 docs](https://docs.dhis2.org/2.29/en/implementer/html/install_read_replica_configuration.html) and
[Postgresql docs]().

### backup history
```
   made dhix user
   90  sudo adduser --disabled-password --disabled-login dhix
   91  sudo su dhix
   92  createuser -s dhix
   93  sudo su dhix

dhix history
    1  cd
    3  vi dhix-env
    4  vi dhix-backup
    5  chmod +x dhix-backup 
   12  chmod 600 dhix-env 
   17  openssl rand -base64 4096 > passwd.pg
   19  chmod 600 passwd.pg 
   21  mkdir backups
   26  ./dhix-backup 
   54  openssl aes-256-cbc -d -pass file:passwd.pg -salt -in backups/backup2018-05-10-daily/dhis.sql.gz.enc | gunzip - | less
   55  openssl aes-256-cbc -d -pass file:passwd.pg -salt -in backups/backup2018-05-10-daily/dhis.sql.gz.enc | gunzip -  > decrypted_backup.sql

crontab -e
# m h  dom mon dow   command
46 09 * * * /home/dhix/dhix-backup
```

