# Kerala server academy

## Exercises Day
There are many ways to install DHIS2.  The process we will follow today emphasises simplicity by using an ubuntu package.  It works well for smaller installations where performance is not a major problem and all components are installed on a single machine.

## Installing DHIS2 tools
Now that we have a reasonably secure system setup from yesterday, we can continue to install the dhis2-tools.  The dhis2-tools were created about 4 years ago, with the aim of providing a simple way to install and manage dhis2 instances on an ubuntu server.  It is a proper ubuntu package which takes care of (i) dependencies and (ii) provides a set of scripts for creating and managing dhis2 instances.

The source code for the package is maintained on [github](https://github.com/dhis2/dhis2-tools).  You only need this if you are planning on modifying or contributing the package itself.

The current packaged version is maintained by Bob Jolliffe and published on [launchpad](https://launchpad.net/~bobjolliffe/+archive/ubuntu/dhis2-tools).  (TODO: this should be moved to dhis2-devs).

Docmentation is maintained in the [implementers guide](https://docs.dhis2.org/master/en/implementer/html/ch20.html).

(work through apache2 and certbot setup)

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

(Add 'disable_ipv6 = true' to /etc/exim4/exim4.conf.template)
