---
title: How to install Rails on a Media Temple DV 4.0
tags: rails
---

First up, the date today is 6 Aug, 2013. I'm working on a Media Temple DV 4.0, with Plesk 11 installed. I'm running CentOS 5.8, using Apache as my webserver. *If those details don't match up closely with what you're using, ignore this post!*

The first thing you should do is create a [snapshot backup](https://kb.mediatemple.net/questions/96/Backing+up+your+server+using+the+Snapshot+Backup+tool#dv_40) of your server. Seriously. Do that before doing anything else.

### Disclaimer

I'm new to Ruby and Rails, and I'm a developer, not a SysAdmin. This is what worked for me, but I'm no expert.

## What we'll need

**[RVM](https://rvm.io/) - Ruby Version Manager**
RVM allows you to install and manage multiple versions of Ruby, and also of Rails and other Gems. You might also have heard of [rbenv](http://rbenv.org/). RVM and rbenv are basically two competing products which do the same thing.

For this post, we'll go with RVM.

Check out this [RVM screencast](http://screencasts.org/episodes/how-to-use-rvm).

**Note:** You probably already have ruby installed on your server. To verify, login with SSH and type `ruby -v`.

The output will be something like:

~~~markup
ruby 1.8.5 (2006-08-25) [x86_64-linux]
~~~

However, it's probably an old version, and it won't be set up in a way that allows you to run one website on ruby 1.9.2 and another on version 2.0. That's why we want RVM.

**[Passenger](https://www.phusionpassenger.com/)**
Passenger is an Application Server for Ruby apps, and therefore, for Rails. [An application server is not a webserver](http://www.javaworld.com/javaworld/javaqa/2002-08/01-qa-0823-appvswebserver.html). So, Passenger is not a replacement for a webserver such as Apache or Nginx.

There are [several Ruby app servers](https://www.engineyard.com/articles/rails-server) we could use, but Passenger is recommended on the [official rails deploy page](http://rubyonrails.org/deploy), so that's what we'll go with.

We'll assume you're using Apache as your existing web server.

## Let's get started

**Note:** I looked at [Tom's guide](https://coderwall.com/p/lu3nfa) when I was installing my first Rails app on Media Temple. It helped me a LOT, but it had some missing steps, some inconsistencies, and some information I found to be not recommended - at least, with regards to my particular setup.

## Prerequisites
You'll need to be able to login to your domain via SSH, with root access. You should also have **a backup** in case something goes wrong!

## Install Developer Tools

Media Temple have a guide on how to [install developer tools](https://kb.mediatemple.net/questions/1672/Installing+Developer+Tools#dv_40). I already had them installed - so I'm not sure if they are required for anything in this post, but you might want to install them to be safe.

## Add your domain in Plesk - one gotcha
I assume you already know how to do this. However, one gotcha is that the Document Root should be set to the `public` folder of your rails install, not the root folder.

So, that means it will be set to `httpdocs/public` rather than the default `httpdocs`.

## Install RVM
Log in to your server via SSH as root.

Before starting, lets make a note of what version of Ruby we've currently got installed. Run `ruby -v`. The output for me is: `ruby 1.8.5 (2006-08-25) [x86_64-linux]`

OK, now install RVM.

~~~markup
\curl -L https://get.rvm.io | bash
~~~

Among other things, it should let you know that:

~~~markup
Installation of RVM in /usr/local/rvm/ is almost complete:

  * First you need to add all users that will be using rvm to 'rvm' group,
    and logout - login again, anyone using rvm will be operating with `umask u=rwx,g=rwx,o=rx`.

  * To start using RVM you need to run `source /etc/profile.d/rvm.sh`
    in all your open shell windows, in rare cases you need to reopen all shell windows.
~~~

So, let's do what it tells us:

### Add users to the RVM group

As it says, lets start by adding the root user to the rvm group:

~~~markup
usermod -a -G rvm root
~~~

Read the full [RVM install page](https://rvm.io/rvm/install) and make sure you understand the security implications *(disclaimer: as of right now, I don't!)* before adding any other users to your RVM group.

Next, run:

~~~markup
source /etc/profile.d/rvm.sh
~~~

That should complete the set up of RVM. You can test it's installed by running `rvm -v`. You should get something like this:

~~~markup
rvm 1.21.17 (stable) by Wayne E. Seguin <wayneeseguin@gmail.com>, Michal Papis <mpapis@gmail.com> [https://rvm.io/]
~~~

## Install Ruby through RVM
At this point, we've installed the Ruby Version Manager, but haven't yet used it to install any versions of Ruby!

To verify this, run `ruby -v`, and you'll see you're using the same version of ruby as when you started (for me, `ruby 1.8.5 (2006-08-25) [x86_64-linux]`). Now, run `which ruby`. For me, the output is `/usr/bin/ruby`, and since there's no mention of `rvm` in that path, I know I'm not using an RVM-managed version of ruby.

Let's fix that.

First, let's take a look at all the versions of Ruby that RVM knows about:

~~~markup
rvm list known
~~~

You'll get a reasonably long list. The [MRI Rubies](http://en.wikipedia.org/wiki/Ruby_MRI) are probably the only ones you're interested in at this stage.

Now, let's install Ruby 1.9.3 (or whichever version you want):

~~~markup
rvm install 1.9.3
~~~

This takes a while. After we've done that, we can re-run `ruby -v` and we should see that we're using the version we just installed. If we run `which ruby`, we should get a path with `rvm` in it, like `/usr/local/rvm/rubies/ruby-1.9.3-p448/bin/ruby`.

Now, let's set version 1.9.3 as the default:

~~~markup
rvm use 1.9.3 --default
~~~

## Instail Rails

We'll use the `gem` command to do this. `gem` is maintainted by RVM, as you'll see if you run `which gem`. OK… rails:

~~~markup
gem install rails -v 3.2.9
~~~

Obviously, you might want to install a different version.

## Use Bundler. Don't use Gemsets

Now, at this point, [Tom's guide](https://coderwall.com/p/lu3nfa) has you create a gemset for your project. I was a bit confused about this, and asked about it on #RubyOnRails IRC channel. The creator of Passenger, FooBarWidget, answered my question, and among other things, said:

*"The tip that I would give you is to completely ignore gemsets. They were introduced before bundler. I consider them legacy technology now that cause more problems and confusion than they're worth."*

I plan on creating a full blog post about not using gemsets, but for now just take it of faith; don't use them.

So, **don't** create a Gemset. Instead, install bundler now, with:

~~~markup
gem install bundler
~~~
We'll use bundler a bit further down the track.

## Installing Passenger
Run:

~~~markup
gem install passenger
~~~

And once it's installed, run:

~~~markup
passenger-install-apache2-module
~~~

This basically allows Passenger (your App Server) to talk to Apache (your Web Server). It will give you a whole bunch of output, hopefully without errors!

At the end, it will give you two crucial bits of information:

**Important Bit 1**

~~~markup
--------------------------------------------
The Apache 2 module was successfully installed.

Please edit your Apache configuration file, and add these lines:

   LoadModule passenger_module /usr/local/rvm/gems/ruby-1.9.3-p448/gems/passenger-4.0.10/buildout/apache2/mod_passenger.so
   PassengerRoot /usr/local/rvm/gems/ruby-1.9.3-p448/gems/passenger-4.0.10
   PassengerDefaultRuby /usr/local/rvm/wrappers/ruby-1.9.3-p448/ruby

After you restart Apache, you are ready to deploy any number of Ruby on Rails
applications on Apache, without any further Ruby on Rails-specific
configuration!

Press ENTER to continue.
~~~
And after you press enter…

**Important Bit 2**

~~~markup

--------------------------------------------
Deploying a Ruby on Rails application: an example

Suppose you have a Rails application in /somewhere. Add a virtual host to your
Apache configuration file and set its DocumentRoot to /somewhere/public:

   <VirtualHost *:80>
      ServerName www.yourhost.com
      # !!! Be sure to point DocumentRoot to 'public'!
      DocumentRoot /somewhere/public
      <Directory /somewhere/public>
         # This relaxes Apache security settings.
         AllowOverride all
         # MultiViews must be turned off.
         Options -MultiViews
      </Directory>
   </VirtualHost>
~~~

Let's deal with **Important Bit 1** first. So, it wants us to edit our apache config file. Before doing that, let's make a backup of it (replace YYYY-MM-DD with the current date!):

~~~markup
cp -p /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.YYYY-MM-DD.bak
~~~

Now, open `/etc/httpd/conf/httpd.conf` with a text editor - I'll use nano:

~~~markup
nano /etc/httpd/conf/httpd.conf
~~~

Then, at the end of the file, add the 3 recommended lines, prefixed by a comment, eg:

~~~markup
# Next 3 lines added by Joss, 2013-07-06. Running 'passenger-install-apache2-module' tells you this is required
LoadModule passenger_module /usr/local/rvm/gems/ruby-1.9.3-p448/gems/passenger-4.0.10/buildout/apache2/mod_passenger.so
PassengerRoot /usr/local/rvm/gems/ruby-1.9.3-p448/gems/passenger-4.0.10
PassengerDefaultRuby /usr/local/rvm/wrappers/ruby-1.9.3-p448/ruby
~~~

## Configure Apache (important bit 2)

**Important Bit 2** tells us how we'll need to configure apache. Unfortunately, that config won't work for us. But don't worry - [Tom's guide](https://coderwall.com/p/lu3nfa) has us covered.

**Reminder:** Remember the *"Add your domain in Plesk - one gotcha"* that I mentioned earlier? It bears repeating. Your rails app will sit in `httpdocs`, but the site, configured in Plesk, should have it's Document Root set to `httpdocs/public`, that is, to the `public` directory inside your rails install.

OK, we're getting close now. Let's `cd` into our site's configuration directory - something like:

~~~markup
cd /var/www/vhosts/mysite.com/conf
~~~
If you do an `ls`, you'll see there are a bunch of numbered files - these are the configuration files automatically maintained by Plesk. Just leave them there - but we're going to create our own configuration file which will take precedence:

~~~markup
nano vhost.conf
~~~

Now, paste in the vhost.conf given in Tom's guide:
*(Be extremely careful to adjust all the paths so they pertain to your site - one wrong path here can cause you a world of pain!)*

~~~markup
ServerName mysite.com
ServerAlias mysite.com
DocumentRoot /var/www/vhosts/mysite.com/httpdocs/public
PassengerAppRoot /var/www/vhosts/mysite.com/httpdocs

<Directory "/var/www/vhosts/mysite.com/httpdocs/public">
        Options FollowSymLinks
        AllowOverride All
        Order allow,deny
        Allow from all
</Directory>

RailsEnv production
RailsBaseURI /
PassengerMaxPoolSize 1
PassengerMaxInstancesPerApp 1
PassengerPoolIdleTime 30
~~~

## Upload Your Files & Database

Hopefully in future, you'll be using something like [Capistrano](http://www.capistranorb.com/) or [Fabric](http://docs.fabfile.org/en/1.7/) to automate your deployment. But for now, let's just upload the files to `/var/www/vhosts/mysite.com/httpdocs` via plain old S/FTP and check if things are working.

You'll also need to create a database and make sure your `database.yml` file is set up right, but I won't go over that here. Using MySQL will be easiest, as it's available out of the box on Media Temple's DV 4.0's. However, Postgres is better - so try and get that working if you're game.

## Install Required Gems

Now, `cd` into the root of your rails installation (the same folder that contains your `Gemfile`), and run:

~~~markup
bundle install
~~~

If it fails due to `sh: git: command not found`, then [install git](https://kb.mediatemple.net/questions/2014/Installing+Git#dv_40) and try again.

If you get errors in your browser, even though `bundle install` seems to work OK, you can try running

~~~markup
bundle install --deployment
~~~
I got that suggestion from [here](http://stackoverflow.com/questions/6648870/is-not-checked-out-bundle-install-does-not-fix-help), and there's more info on the `--deployment` option [here](http://bundler.io/v1.3/man/bundle-install.1.html#DEPLOYMENT-MODE).

Basically, `bundle install` will look through our `Gemfile` and download everything we need to run our application.

## Precompile Assets

Now, you'll need to precompile your assets. From your `httpdocs` directory, run

~~~markup
bundle exec rake assets:precompile
~~~
If you get an error like `Could not find a JavaScript runtime`, then you'll need to add `therubyracer` to your `Gemfile`, and then re-run `bundle install`, and then re-run `bundle exec rake assets:precompile`.

Last but not least, once your assets are precompiled, restart passenger by running this from within the `httpdocs` directory:

~~~markup
touch tmp/restart.txt
~~~

If you've done things right, at this point, your app should work. But if you're unlucky like me, and you get an error like: `This web application process is being run as user 'nobody' and group 'nobody' and must be able to access its application root directory` then read [this post](/post/solution-to-passenger-running-as-user-group-nobody).

If you think you need to restart anything, for any reason, you can:

`cd` into your `httpdocs` directory, and restart passenger with:

~~~markup
touch tmp/restart.txt
~~~

And you can restart apache with

~~~markup
/etc/init.d/httpd restart
~~~
