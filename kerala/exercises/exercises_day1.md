# Kerala server academy

## Exercises Day 1
The following exercises are designed for participants to acquire particular skills and tips for installing ubuntu server and installing dhis2.

### Operating System
####  Install ubuntu 16.04 on linode
This exercise involves building a system on the linode.  We will run through the process interactively (step by step), but in a production setting this is not the preferred method.  Nowadays it is more common to provision servers dynamically.  We will go through manually first and later in the day discuss how to automate the process.

You need to go to the linode control panel, and login with your credentials. Select your linode and create a new configuration using ubuntu 16.04 64 bit edition. A useful guide for getting started is available [here](https://www.linode.com/docs/getting-started#provisioning-your-linode).

After installation is complete, you can boot the server and get access to its running console.  You can do this by going to the "Remote Access" tab of the linode control panel and clicking on "Launch Lish Console" at the bottom of the page.

![](lish.png)

Lish is in some ways equivalent to sitting in front of a physical machine.  Later you will access the server via ssh, but having the ability to access directly via lish is an important fallback in case you are somehow locked out of access via ssh.

> Note:  lish is a utility specific to linode.  Other hosting
> providers will have different ways to accomplish the same thing.

As a precaution while we are feeling our way around the system it is a good idea to prevent outside network access.  At least until we have secured things a bit better.  Newborn servers are often the most vulnerable as they have not yet been properly patched and configured. A common mistake is that when someone acquires a new machine they power it up, connected to the internet, and then leave it running with the intention of coming back to configure later.  If you are not going to deal with it immediately switch it off.  Hackers are constantly probing for running machines and will chance upon yours surprisingly quickly.

A simple way to keep us a bit safer is to enable a simple host based firewall.  Ubuntu server comes by default with `ufw` (uncomplicated firewall).  We will be discussing firewalls in more detail later, but for now just type:

```bash
ufw enable
```
Without any other firewall rules applied, this will simply block **all** network traffic to the server which is a good safety precaution.

So for the moment `lish` is the only way in.

####  Configure a user to administer the system

When the system is initially installed it has a `root` user by default.  The convention on ubuntu systems is never to login as root, but rather configure a human user and grant that person privileges to perform operations as root.  There (at least) two good reasons for this:
1.  It makes it slightly harder to make a silly mistake
2.  It provides a proper audit trail of who has logged in and when
(for this reason it is preferable that the user account is linked to a human being rather than something generic like `dhis`).

The commands to create a new user and give her permission to execute commands as root are:
```bash
adduser bobj
usermod -a -G sudo bobj
```
The first line creates the user.  It is an interactive process. Generally it is a good idea to set the real name of the user, but most of the rest can be ignored.

`usermod` is used to **modify** the user.  The specific modification that is being done here is that the user `bobj` is being added to a group of users called `sudo` (more on users and groups later).  Users in the `sudo` group have the permission to execute commands as the `root` user.  So there is no more reason to be able login as `root`.

Logout of the system (`exit`) and log back in as your new user.

####  Update the system with latest package upgrades
# prefer ipv4 addresses - this solves long delays with apt-get
echo "precedence ::ffff:0:0/96  100" >> /etc/gai.conf

It is important that the operating system is kept up to date with the latest packages.  Particularly when there are security related packages.

This is a two step process.  The first is to download the latest list of packages:
```bash
apt-get update
```
When you run this as your user you will get an error message.  You need to be the `root` user in order to update packages on the system. Because your user is in the `sudo` group, she is able to run commands as root by prefixing `sudo` to the command:
```bash
sudo apt-get update
```
Now you will be prompted for your password and the update will begin.

You can get a full description of what `update` does by looking at the manual page for the `apt-get` command.  You do this with:
```bash
man apt-get
```

> A common mistake with beginners, once they have discovered that `sudo`  allows them to do useful things is that they start to use `sudo` for **everything**.  Try and resist this temptation and only use sudo when you need to.  This can help you avoid many difficulties,  mistakes and disasters.. Note we didn't need to `sudo` in order to read the manual.

Now that you have your updated list of packages installed, you can upgrade your base system with the latest software.  You will have seen from the manual page that there are different types of upgrade that can be done.  In this case, because the server is new, we will use the most aggressive:
```bash
sudo apt-get dist-upgrade
```
A more cautious approach you might use when the system is in production is to just use `apt-get upgrade`.

> Discussion point: it is an open question whether to configure your system to automatically update itself as new versions of packages are released or to always do this manually.  A halfway position (which we recommend for most setups) is to ensure that all security related patches are applied automatically. The official ubuntu server docs explain how to set up unattended upgrades [here](https://help.ubuntu.com/lts/serverguide/automatic-updates.html).

As an exercise, setup unattended upgrades for your linode now.

### SSH
>Note: Document steps in detail

#### Securing the ssh daemon (server)
The primary way in which administrators interact with the backend system on a linux server is using ssh (secure shell).  A linux server usually has an ssh server program installed on it (sshd).

Linux (and other unix derivatives) make use of openssh, which is usually included as part of the base install.  Openssh is the most widely used implementation of openssh which means it is generally quite secure.  When vulnerabilities are discovered they are typically patched quickly.

There are a number of ways to improve your default ssh configuration.  Typically you might:
1.  Disable root login via ssh.
2.  Disable password based login, and require the use of ssh keys.
3.  Change the listening port that ssh listens on from 22 to something else (preferably below 1024 .. discussion?)

You should definitely do the first option in this list (after we have configured ssh keys we will also do the second).  It involves editing a file called `/etc/ssh/sshd_config` and changing the line which contains "PermitRootLogin" to **no**.  There are a number of linux text editors available.  Experienced admins tend to use `vi`, but beginning users might prefer to use `nano`.  Go ahead and edit the file with:
```code
sudo nano /etc/ssh/sshd_config
```
After you have disabled root login, you can go back to the firewall and enable access to the ssh port:
```bash
sudo ufw limit ssh/tcp
```
(discuss ufw limit)
At this point, if you have an ssh client, you should be able to access your linode using ssh, using its IP address or its fully qualified domain name (FQDN - more on this later).

#### Installing an ssh client on your workstation (if necessary)
Windows users will typically have to install additional software in order to be able to connect.  There are three options which we can recommend (probably there are more).

1.  *Putty*:  Putty is probably the best known ssh client for windows.  There are many guides with Information for setting up putty, for example [here](https://www.linode.com/docs/networking/ssh/using-putty).
2.  *Cygwin*:  Another option (which I prefer) is to install the cygwin tools on your windows machine.  This comes with a set of commandline tools (including bash shell and openssh) which allows you to work in a similar manner to a linux machine.
3.  *Windows 10 linux subsystem*: This is a very recent option you can take advantage of if you are running an up to date version of Windows 10.  Its a bit tricky to setup, but it seems to work well enough.  It results from a collaboration between Canonical and Microsoft which aims to run linux applications "*natively*" on windows.  More information to setup [here](https://msdn.microsoft.com/en-us/commandline/wsl/install_guide).

#### ssh with public keys
This exercise involves setting an ssh key pair, and copying the public part of the pair to the linux server.  This allows logging in without using a password.  This is the preferred method.

(Discussion on assymetric vs symetric encryption methods - ssh, ssl/tls, pgp)

If you do not yet have a keypair and/or do not know how to generate one, sit with someone now who can explain how to do it using your particular environment.

#### Some tips and tricks using ssh
1. Executng commands over ssh.
2. Incorporating ssh into pipelines
3. Ssh tunneling (save this one till tomorrow)

## Automating the installation
The process we have gone through today is long, detailed and prone to error.  It is quite likely that we might forget a few steps here and there.  There are a number of systems which help with automatic the provisioning of systems.  The most well known ones are probably vagrant, ansible, puppet and chef.  Automatic provisioning means that deploying a system is much quicker but also (more importantly) it allows you to enforce standards for configuration.

The simplest form of automation is just to run a bash script which goes through the configuration steps.

Linode provides a mechanism for organising and parameterizing these scripts, called **StackScripts**.

Below is a simple example of a script which automates most of the steps we have discussed above.
```bash
#!/bin/bash
#       ____  __  ______________
#      / __ \/ / / /  _/ ___/__ \
#     / / / / /_/ // / \__ \__/ /
#    / /_/ / __  // / ___/ / __/
#   /_____/_/ /_/___//____/____/
#
#   Installation stackscript
#
#<UDF name="myuser" label="Username:">
#<UDF name="ssh" label="SSH Public Key:">
#<UDF name="sshport" label="SSH Port:" default="22">
#<UDF name="hostname" label="The hostname for the new Linode.">
#<UDF name="fqdn" label="The new Linode's Fully Qualified Domain Name">

# enable firewall
ufw enable

export DEBIAN_FRONTEND=noninteractive
# This updates the packages on the system from the distribution repositories.
apt-get update
apt-get upgrade -y

# This sets the variable $IPADDR to the IP address the new Linode receives.
IPADDR=$(/sbin/ifconfig eth0 | awk '/inet / { print $2 }' | sed 's/addr://')

# This section sets the hostname.
echo $HOSTNAME > /etc/hostname
hostname -F /etc/hostname

# Create administrative user
useradd -m -G sudo -s /bin/bash ${MYUSER}

# Perform tasks for new user
# set a temporary password
echo $(</dev/urandom tr -dc A-Za-z0-9 | head -c 10) > /home/$MYUSER/passwd.txt
chmod 600 /home/$MYUSER/passwd.txt
echo "${MYUSER}:$(cat /home/${MYUSER}/passwd.txt)" | chpasswd

# This sets your public key on your Linode
mkdir /home/$MYUSER/.ssh
echo "${SSH}" >> /home/$MYUSER/.ssh/authorized_keys
chmod 600 /home/$MYUSER/.ssh/authorized_keys

# make sure user owns everything
chown -R $MYUSER.$MYUSER /home/$MYUSER

# Tighten up ssh
# Disables password authentication
sed -i 's/#*PasswordAuthentication [a-zA-Z]*/PasswordAuthentication no/' /etc/ssh/sshd_config
# Disable root login
sed -i 's/PermitRootLogin [a-zA-Z]*/PermitRootLogin no/' /etc/ssh/sshd_config
# Change Port
sed -i "s/Port [0-9]*/Port $SSHPORT/" /etc/ssh/sshd_config
# This restarts the SSH service
service ssh restart

# Allow ssh through firewall
ufw limit $SSHPORT/tcp
```
