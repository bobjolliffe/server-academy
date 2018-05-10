# Kerala server academy

## Catching up on things we missed
1.  Setting up mail
2.  Country presentations (Nepal, ...)
3.  Upgrading dhis2 war file
4.  Backups
5.  Encrypted at rest data (tomorrow)
6.  Automating certbot renewal

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

