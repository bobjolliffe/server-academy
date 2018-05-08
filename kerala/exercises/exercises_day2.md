# Kerala server academy

## Exercises Day
There are many ways to install DHIS2.  The process we will follow today emphasises simplicity by using an ubuntu package.  It works well for smaller installations where performance is not a major problem and all components are installed on a single machine.

## Installing DHIS2 tools
Now that we have a reasonably secure system setup from yesterday, we can continue to install the dhis2-tools.  The dhis2-tools were created about 4 years ago, with the aim of providing a simple way to install and manage dhis2 instances on an ubuntu server.  It is a proper ubuntu package which takes care of (i) dependencies and (ii) provides a set of scripts for creating and managing dhis2 instances.

The source code for the package is maintained on [github](https://github.com/dhis2/dhis2-tools).  You only need this if you are planning on modifying or contributing the package itself.

The current packaged version is maintained by Bob Jolliffe and published on [launchpad](https://launchpad.net/~bobjolliffe/+archive/ubuntu/dhis2-tools).  (TODO: this should be moved to dhis2-devs).

Docmentation is maintained in the [implementers guide](https://docs.dhis2.org/master/en/implementer/html/ch20.html).

(work through the documentation and discuss)


### Using the package (exercises)
1.  make your user a dhis2 administrator
2.  create an instance called hmis
3.  modify heap RAM allocation.
4.  modify proxy configuration so instance is served as default
5.  install the latest dhis2 war
6.  start, stop, monitor log
7.  restore the database from backup

### Discussion of improvements
1.  package could support separate proxy and database without "tweaking"

####  Install email mta (postfix or exim4)

Instructions for installing exim4 as a send-only mail service are [here](https://www.dhis2.org/setting-up-email-on-server).

Postfix is much more commonly used on linux than exim4.  As an exercise we should go through the steps for installing postfix.  It is very similar.  The most important thing is that your FQDN has been properly setup.

Note: there seems to be a permissions problem with default ubuntu 16.04 install.  `syslog` is unable to write to `/var/log`.
```code
bobj@instructor:~$ ls -l /var
total 40
drwxr-xr-x  2 root root   4096 Mar 20 20:23 backups
drwxr-xr-x 11 root root   4096 Mar 20 14:56 cache
drwxr-xr-x 43 root root   4096 Mar 20 14:48 lib
drwxrwsr-x  2 root staff  4096 Apr 12  2016 local
lrwxrwxrwx  1 root root      9 Jul 22  2016 lock -> /run/lock
drwxr-xr-x 11 root syslog 4096 Mar 20 14:48 log
drwxrwsr-x  2 root mail   4096 Mar 20 14:36 mail
drwxr-xr-x  2 root root   4096 Jul 22  2016 opt
lrwxrwxrwx  1 root root      4 Jul 22  2016 run -> /run
drwxr-xr-x  5 root root   4096 Mar 20 14:24 spool
drwxrwxrwt  3 root root   4096 Mar 21 03:11 tmp
drwxr-xr-x  3 root root   4096 Mar 20 14:48 www
bobj@instructor:~$ sudo chmod 0775 /var/log
bobj@instructor:~$ ls -l /var
total 40
drwxr-xr-x  2 root root   4096 Mar 20 20:23 backups
drwxr-xr-x 11 root root   4096 Mar 20 14:56 cache
drwxr-xr-x 43 root root   4096 Mar 20 14:48 lib
drwxrwsr-x  2 root staff  4096 Apr 12  2016 local
lrwxrwxrwx  1 root root      9 Jul 22  2016 lock -> /run/lock
drwxrwxr-x 11 root syslog 4096 Mar 20 14:48 log
drwxrwsr-x  2 root mail   4096 Mar 20 14:36 mail
drwxr-xr-x  2 root root   4096 Jul 22  2016 opt
lrwxrwxrwx  1 root root      4 Jul 22  2016 run -> /run
drwxr-xr-x  5 root root   4096 Mar 20 14:24 spool
drwxrwxrwt  3 root root   4096 Mar 21 03:11 tmp
drwxr-xr-x  3 root root   4096 Mar 20 14:48 www
bobj@instructor:~$
```
Now that logs exist we can see there is a complaint from google mail servers in the log file related to IPv6 configuration when we try and send mail:
```code
Our system has detected that this 550-5.7.1 message does not meet IPv6 sending guidelines regarding PTR records 550-5.7.1 and authentication.
```
The simplest solution is to disable IPv6.  So the following changes to /etc/postfix/main.cf:
```
#inet_interfaces = all
#inet_protocols = all
inet_interfaces = 127.0.0.1
inet_protocols=ipv4
```
Then `sudo service postfix restart` and mail is up and running.  Note above I also shifted the interface to be sure postfix won't accept outside mail.
