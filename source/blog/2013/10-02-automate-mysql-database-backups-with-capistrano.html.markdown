---
title: Automate MySQL Database Backups with Capistrano
tags: mysql capistrano
---

I was looking for a way to:

*a)* Run regular MySQL database backups, keeping eg. daily copies for the past week, monthly for the past year, etc.

*b)* Backup the database prior to each capistrano deployment, and download a copy of the backup to my own computer.

I've found a solution I'm happy with, so I thought I'd share it here.

## a) Regular, Automated MySQL Backups

*a)* was easy. [AutoMySQLBackup](http://sourceforge.net/projects/automysqlbackup/) will take care of it all for you, and is well documented in it's README. I was surprised to see it on sourceforge and not github, but it still appears to receive somewhat regular updates, so I went ahead and installed it.

As I mentioned, it's well documented, so I won't go over the how-to here, but basically it allows you to create backups of any number of databases on your system, and by changing a few numbers in a config file, it allows you to set requirements for how many copies to keep, for how long.

So, you can keep daily backups for the past week, monthly backups for the past year, and so on - however you see fit. Run it via a daily cron job, and that's half your problem solved.

**Note:** If you happen to come across the error below, [this](http://sourceforge.net/p/automysqlbackup/discussion/350022/thread/8f17e483/) fixes it.

~~~markup
###### WARNING ######
Errors reported during AutoMySQLBackup execution.. Backup failed
Error log below..
du: WARNING: use -si, not -H; the meaning of the -H option will soon
change to be the same as that of -dereference-args (-D)
~~~

## b) Backup and Download Database on Capistrano Deploy

*b)* was a little tricker, but with some inspiration from [here](http://stackoverflow.com/questions/13638112/how-to-create-a-capistrano-task-to-download-latest-database-backup-tgz-and-impor), this is what I came up with:

~~~ruby
namespace :deploy do
  task :backup_database, :roles => :db do
    run "automysqlbackup /etc/automysqlbackup/myserver.conf"
    backups_path = "/var/backup/db/daily/your_database/"
    latest_backup = capture "ls -t #{backups_path} | head -1"
    latest_backup.strip!
    run_locally "scp #{user}@#{domain}:#{backups_path}#{latest_backup} ../live_db_backups/#{latest_backup}"
  end
end
~~~

And you can run it before updating, like this:

~~~ruby
before "deploy:update", "deploy:backup_database"
~~~

## Breaking down the capistrano task, line by line

If you're one to copy/paste code without understanding it, don't. Read this. There's essentially only 5 lines of code (excluding the task definition), so lets break them down:


### 1. Run the AutoMySQLBackup

~~~ruby
run "automysqlbackup /etc/automysqlbackup/myserver.conf"
~~~

This just runs the AutoMySQLBackup script we set up in part a). You'll need to change myserver.conf to the name of your config file, and also change the path to the config file if you didn't do a standard install.

If you've gone through part *a)*, this should be pretty familiar.

### 2. Set the path to your backups

~~~ruby
backups_path = "/var/backup/db/daily/your_database/"
~~~
This is easy - just store a path to your database backups. If you've done a standard install of AutoMySQLBackup, then it should look similar to the above.

### 3. Get the name of the latest backup file

~~~ruby
latest_backup = capture "ls -t #{backups_path} | head -1"
~~~

The `capture` method is the same as `run`, but it'll return the output for you - which we then store in our `latest_backup` variable.

Running `ls -t` will list the contents of the directory (in our case, the directory of our backups), sorted by time modified (most recently modified first). So, the first line of it's output will be our latest backup.

`head -n` displays the first *n* lines of a file.

The pipe operator - `|` - allows you to feed the output (stdout) of one process to the input (stdin) of another process. So, we're feeding the output of our `ls -t` command into our `head -1` command.

To sum up, we're listing the files in our backups directory, ordered by date modified, and then taking the first line and storing it in a local variable.

### 4. Trim white space

~~~ruby
latest_backup.strip!
~~~

In step 2, we get the entire first line - including the new line character on the end. We only want the name of the backup file, so this method just strips white space off our variable.

### 5. Download it!

~~~ruby
run_locally "scp #{user}@#{domain}:#{backups_path}#{latest_backup} ../live_db_backups/#{latest_backup}"
~~~

Capistrano's `run_locally` executes the command on your local machine, as opposed to on a remote server.

`scp` allows you to securely copy a file from one host to another (in our case, from our server to our local machine). It provides the same security / authentication as ssh.

So, all we do is pass the full path to our remote backup (`#{user}@#{domain}:#{backups_path}#{latest_backup}`) as the first param, and a location on our local machine as our second.

Note that `:user` and `:domain` will need to have been set earlier in your `deploy.rb` file.

The path I've chosen on my local machine, `../live_db_backups/#{latest_backup}` will just copy the database backup, keeping it's original name, to a folder just above my current directory. But you can copy it anywhere you want on your hard drive, and give it any name you want.
