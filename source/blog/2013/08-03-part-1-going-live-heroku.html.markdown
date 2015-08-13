---
title: Part 1 - Going Live - Heroku WTF's
tags: rails
---

This post is [part of a series](http://joshuapaling.com/post/rails-blog-in-15-weeks)

Here we'll go over 'WTF' moments from the last few steps of [Part 1](http://www.reinteractive.net/posts/32-ruby-on-rails-3-2-blog-in-15-minutes-step-by-step) - publishing our blog on Heroku.

It happens pretty fast - you sign up for Herkoku, install the Heroku toolbelt, run a few commands at the terminal and then your blog is live.

**WTF?**

* We didn't create a database.
* We didn't explicitly upload anything.
* We didn't change our database.yml file to handle our production setup
* We didn't specify anything about what server we wanted to connect to

## Heroku is Unique

Yep, you'd probably already figured that by now.

Heroku is a hosting service that *doesn't allow you write access to the file system*. Really. On Heroku, you (personally) can't write to the file system. You have no SSH access, no FTP access, no SFTP access, no… you get the picture.

Everything is done through:

 1. **Heroku's online interface** (we only used it to sign up - but you can also use it to add premium services to your account)

 2. **The heroku toolbelt** (ie, the command line tool we installed)

If you're app itself needs to handle image uploads (ours doesn't) then you can't write the images to Heroku's server (no write access, remember?). You have to [store them on Amazon S3](https://devcenter.heroku.com/articles/s3) or something like that.

Make sense? Again, Heroku doesn't allow write access. We have to upload our app via the Heroku toolbelt command line tool.

## The 3 magic commands - explained

After installing the Heroku toolbelt, we run 3 little commands, and our app is live. They are:

~~~markup
heroku create
git push heroku master
heroku run rake db:setup
~~~

Let's break it down:

### 1. heroku create
We're using the heroku toolbelt we just installed to turn our rails blog into a heroku app. There's two main things to take note of here:

* After running the command, the URL for your live heroku app will printed out at the terminal. So, take note of it. They have cool names like **http://frozen-bastion-1730.herokuapp.com/**
* The command also adds the Heroku server as a remote repository of our existing git repo - which is crucial for our next command.

### 2. git push heroku master
You know what git push does, right? If not, learn git before writing another line of code! It just pushes changes from our local git repository up to our specified remote repository - in this case, `heroku master`.

But if you where wondering what the hell that `heroku master` repository is, and how it got there, now you know. Heroku created it for us when we ran `heroku create`.

### 3. heroku run rake db:setup
Pretty self-explanatory, but there's some magic under the hood here too.

We're setting up the database via Heroku's toolbelt (duh!). We're using rake, which we've used before, to create and setup our database from the migration files in our app.

**Now for the magic part**

Sharp coders might have noted that in our `database.yml`, our production config still looks like this:

~~~markup
production:
  adapter: sqlite3
  database: db/production.sqlite3
  pool: 5
  timeout: 5000
~~~

 And you'll be thinking *I thought Heroku doesn't support SQLite?* Well, it doesn't. Heroku will automatically replace our database.yml file with it's own. That's right, ours just gets deleted, and another Heroku-compatible one is put in it's place, with the right database name, driver etc.

It might be a good idea to change the above code to something like:

~~~markup
# production:
  # heroku replaces database.yml
  # so we don't need to specify anything here
~~~