---
title: Install Postgres on a Media Temple DV 4.0
tags: postgres
---

If you've reached this post, you probably already know… Postgres is generally considered [better than MySQL](http://www.anchor.com.au/hosting/dedicated/mysql_vs_postgres). MySQL is more common, and therefore a bit easier to get up and running (it'll come out of the box with a lot of hosts). Here's how to setup Postgres on Media Temple DV 4.0, running CentOS 5.8.

## Disclaimer
I'm new to Postgres. I'm a programmer, not a DB Admin, or a SysAdmin. I'm writing this post primarily for my own reference, and to help solidify my own understanding. **Keep in mind I'm no expert!!!**

## My Setup

First up, the date today is 8 Aug, 2013. I'm working on a Media Temple DV 4.0, with Plesk 11 installed. I'm running CentOS 5.8, 64 bit version, using Apache as my webserver. *If those details don't match up closely with what you're using, ignore this post!*

## Media Temple Have a Guide, But Don't Use It

Media Temple have [some instructions](https://kb.mediatemple.net/questions/723/How+do+I+install+PostgreSQL+on+my+server%3F#dv_40) on how to install postgres - but following them verbatim will make the yum package manager install a pretty old version, which probably isn't what you want. There's a few other issues with that set of instructions, too, such as the fact that passwords are encrypted in Plesk 11 (they weren't in earlier versions), so the commands media temple use regarding passwords no longer work. So I'd ignore that guide all together.

## Yum Only Knows About Older Versions

### First, let's check that yum does in fact only have old versions

ssh into your server, and run

~~~markup
yum list postgres*
~~~

This will list all packages yum knows about, starting with *postgres*.

To check you're runnning the 64 bit version of CentOS, execute `uname -a` and you should see `x86_64` somewhere in the output. If you're on a Media Temple DV 4.0, you'll be running 64 bit.

If we're running 64 bit, then really the only packages we're interested in are the ones ending in x86_64. So, we could list them alone with

~~~markup
yum list postgres*x86_64
~~~
There's a bunch of versions, and we're only after the latest. Check the lastest stable release of Postgres on [the official website](http://www.postgresql.org/). As of today (8 Aug 2013), it's 9.2.4.

However, the latest version we've got listed in yum is 8.4, which is earlier than we want.

### Convinced that yum doesn't know about the latest version? OK, now for why…

The reason for this is that [REHL](http://www.redhat.com/products/enterprise-linux/) doesn't try to stay up to date - it has **very** stable versioning. The true *'latest stable version'* won't be available in yum for quite a while after it's released.

## So How Do We Get The Latest Postgresql?

Luckily, the Postgres maintainers provide newer releases for RHEL and Fedora, [here](http://yum.postgresql.org/repopackages.php). The RPM we're after is called `Red Hat Enterprise Linux 5 - x86_64`, and it's available at [http://yum.postgresql.org/9.2/redhat/rhel-5-x86_64/pgdg-redhat92-9.2-7.noarch.rpm](http://yum.postgresql.org/9.2/redhat/rhel-5-x86_64/pgdg-redhat92-9.2-7.noarch.rpm).

There are better instructions on the [Postgres Wiki](http://wiki.postgresql.org/wiki/YUM_Installation) for how to install lastest versions using yum.

We'll basically follow along with those instructions, but I'll add the exact commands I use, for my setup (Media Temple DV 4.0, CentOS 5, Postgresql 9.2)

#### Configure your yum repository

First, you might want to make a date-stamped backup:

~~~markup
cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.BAK.2013-08-08
~~~
Now, let's open `/etc/yum.repos.d/CentOS-Base.repo` with a text editor. I'll use nano.

~~~markup
nano /etc/yum.repos.d/CentOS-Base.repo
~~~

At the end of both the `[base]` and `[updates]` sections, add the suggested line, and add a comment on the end if you want, to remind yourself of why it's there:

~~~markup
exclude=postgresql* # added on 2013-08-08, based on http://wiki.postgresql.org/wiki/YUM_Installation
~~~
Save with `Control-O`, and exit with `Control-X`.

#### Download and install PGDG RPM file

For 9.2.6 on CentOS 5, we run:

~~~markup
curl -O http://yum.postgresql.org/9.2/redhat/rhel-5-x86_64/pgdg-centos92-9.2-6.noarch.rpm
 ~~~
You'll obviously need to adjust the URL if you want a different packed. Check which package you want [here](http://yum.postgresql.org/repopackages.php).

Now, install it - use `rpm -ivh `, followed by the last part of the URL in the above command. So,

~~~markup
rpm -ivh pgdg-centos92-9.2-6.noarch.rpm
~~~

Now yum should be able to see the version we installed. Check, with

~~~markup
yum list postgres*
~~~

#### Install PostgreSQL 9.2

~~~markup
yum install postgresql92 postgresql92-server postgresql92-devel
~~~

**NOTE:** you may not need the `postgresql92-devel` option. I do need it, for the Rails pg gem, which I'll install later. Either way, it doesn't really hurt to have it there.

Now, initialise the database with

~~~markup
service postgresql-9.2 initdb
~~~

Now, make PostgreSQL start automatically when the Operating System starts:

~~~markup
chkconfig postgresql-9.2 on
~~~

Note that we'll be able to start / stop / restart / reload with the following commands:
`service postgresql-9.2 start`
`service postgresql-9.2 stop`
`service postgresql-9.2 restart`
`service postgresql-9.2 reload`

If those commands fail, this should also do it:

`/etc/init.d/postgresql-9.2 start`
`/etc/init.d/postgresql-9.2 stop`
`/etc/init.d/postgresql-9.2 restart`
`/etc/init.d/postgresql-9.2 reload`

So now, start the Postges server:

~~~markup
service postgresql-9.2 start
~~~

Note that the path to the postgres configuration file will be `/usr/pgsql-9.2/bin/pg_config`.

## Postgres is installed. Now what?

At this point, you should read through the [official tutorial](http://www.postgresql.org/docs/current/static/tutorial.html). A lot of it is basic SQL stuff, but skim it anyway and pay particular attention to Postgres-specific stuff. There's also a  [first steps after installation](http://wiki.postgresql.org/wiki/First_steps) wiki page - though it's not official (anyone can edit the wiki), and I personally found it to be a bit confusing.

I plan on writing another post on questions I had after installing postgres, and suggested first steps. But for now, I'm done."

#### Note:

For lots of stuff (creating users, database, etc), you'll have to be using ssh as the postgres user. You do this by executing `su - postgres`.

## Addendum 1 - allow user / password authentication

By default, postgres will use `ident` authentication, which you won't be familiary with if you're coming from MySQL. You can read a great article about it [here](http://www.upfrontsystems.co.za/Members/izak/sysadman/postgresqls-confusing-authentication-configuration). You can read about all of Postgres' authentication means [here](http://www.postgresql.org/docs/9.0/static/auth-methods.html). Because I'm coming from MySQL, and I'm keen to get this thing up and running, for now I'm just going to change `ident` to `md5` authentication, which basically means it'll work the same way as I'm used to in MySQL.

To change that, we'll need to edit `pg_hba.conf`:

~~~markup
nano /var/lib/pgsql/9.2/data/pg_hba.conf
~~~

Find the line that says:

~~~markup
host    all             all             127.0.0.1/32            ident
~~~
and change `ident` to `md5`. You might like to leave the existing line there commented out for future reference:

~~~markup
# host    all             all             127.0.0.1/32            ident
host    all             all             127.0.0.1/32            md5
~~~
Save with `Control-O`, and exit with `Control-X`.

Then, restart postgres with `service postgresql-9.2 restart`.

## Addendum 2 - installing pg gem, for Rails

You may find you need to specify the path to the postgres config, something like this (adjust the version number for your situation):

~~~markup
gem install pg -v '0.15.0' -- --with-pg_config=/usr/pgsql-9.2/bin/pg_config
~~~

If you get errors still, you may want to try Christian's solution for Postgres gem on CentOS 5.8, [here](http://stackoverflow.com/questions/4827092/unable-to-install-pg-gem) (ie, `export PATH=/usr/pgsql-9.2/bin:$PATH` and then `bundle install`)

## Addendum 3 - ensure pg_config works
Type `pg_config` at the terminal. If you get "command not found" you'll need to add pg_config to your path. You can add it for the *current session only* with this:

~~~markup
export PATH=$PATH:/usr/pgsql-9.2/bin/
~~~

However, you'll probably want to add it to your path permanently, and I'll let Google help you out there.
