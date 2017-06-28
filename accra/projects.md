# Server Academy Projects

The following is a short list of suggested projects, graded by difficulty.  To get the most out of these you should select projects which (i) suit your level of experience and (ii) address some real problem you have in your environment.

## For the less experienced
### Practice install process
We have gone through the installation of dhis2 with apache2 and exim4 once or twice quite quickly.  It is a good exercise to repeat this process yourself once or twice so that you feel comfortable with the process.  Make a note of any issues you encounter or suggestions for improvement which you can present back to the group.

### Creating a backend user
It is a common challenge to create a new user on the system.  You do not want to exchange the password for the new user by email.  Get a fellow participant to send you a username and ssh public key by email.  Create the new user with ssh access and leave her password in a protected file in her home directory.  Test.  As an additional challenge, can you write a script to make this job easier?

## Slightly harder
### Database backups
You will need to work with another team for this exercise as you need access to two linodes (one as the designated archive server).  In the `dhix` folder there is a script for automating and encrypting backups.  Configure this script to backup and encrypt your databases and ship them to the archive server.

Variations:
1.  Can you configure this to go the other way ie. the archive server pulls the backups rather pushing to the archive server.
2.  Restoration.  You only know you have good backups if you have tested restoring them.  Write a script to fetch encrypted backups from the archive server and test restore.  Send alert if there is an error.

## Database performance benchmarking
Create some realistic queries for pgbench. 

## Apache2 conf file
Create  really good(!!) apache2 conf file to distribute with dhis2-tools.

## Experienced sysadmins
### Setup apache2 mod_security.  
Test for false positives.  Assess rulesets from owasp, atomic.  Configure custom error page.

### Containerize everything
Remove postgres, apache2, dhis2-tools, instances, java. Install lxd and create 3 containers - one each for proxy, database and instances.  Configure iptables to forward ports 80/443 to proxy container.

