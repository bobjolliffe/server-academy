# Configuration
## Server side
The server side configuration file is in /etc/ssh/sshd_config.  There are some useful settings to make your setup more secure.  In particular, it is worth looking at:

`Port 22`
Consider changing, though do not set to above 1024.  Note this does not make ssh more secure, but will lessen the number of random probes you get in your logfile.

`PermitRootLogin no`
You generally do not want to allow root access via ssh.

`PasswordAuthentication no`
Oblige the use of ssh keys.

## Client side
you can use .ssh/config to cutomize ssh behviour for different sites tht you visit.  Eg.
```
Host instructor
Hostname instructor.dhis2.org
Port 822
```
(see also tunnels below)

# Remote code execution
You can specify a command to run on the remote host.  For example, to reboot my tomcat instance:
`ssh instructor 'dhis2-shutdown dhis; dhis2-startup dhis'`

Or, if I have a number of instances:

`ssh instructor 'for instance in dhis1 dhis2 dhis3; do dhis2-shutdwom $instance; dhis2-startup $instance; done'`

This is often useful when you want to collect the output of remote command into a local file.  For example:

`ssh instructor 'grep "Catalina start" /var/lib/dhis2/dhis/logs/catalina.out' > instructor_tc_starts.txt`

Or

`ssh instructor 'psql -c "select name,uid from orgnisationunit"' > ous.txt`

It also is infinitely more comfortable than typing commands in a remote shell over an unstable internet connection.

Besides redirection, ssh can also be combined into pipelines.  What do you think this does?
`ssh instructor 'tar zcf /etc/apache2 -' | tar zxf -`

There are an infinite number of uses for ssh to work with remote machines.  Though primitive on the surface, it is far more flexible than gui type interfaces.

# Tunnelling
As good practice, some services running on the server are configured to listen only on the local interface.  For example postgres listening internally on localhost:

`ssh -N -L 9000:localhost:5432 instructor`

You can put your tunnel into ssh config file:

```
Host instructor_pg
    Port 822
    HostName instructor.dhis2.org
    LocalForward 9000 127.0.0.1:5432
```

Or to connect using the unix domain socket:
```
Host instructor_pg
    Port 822
    HostName instructor.dhis2.org
    LocalForward 9000 /var/run/postgresql/.s.PGSQL.5432
```



