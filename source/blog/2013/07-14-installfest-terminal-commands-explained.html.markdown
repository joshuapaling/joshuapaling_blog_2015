---
title: InstallFest Terminal Commands Explained
tags: rails
---

This post is [part of a series](http://joshuapaling.com/post/rails-blog-in-15-weeks)

You use several command line tools throughout the blog tutorial, and you'll copy/pasted several commands into the terminal. Here's a bit more explanation on each command.

### rails

When you install the Rails gem, you also get the rails command line tool - aptly named… wait for it… rails. At some point, read the [full doco](http://guides.rubyonrails.org/command_line.html).

*Here's what we use in the tutorial:*

**Create a new app**

~~~markup
rails new quick_blog -T
~~~

This creates a folder called 'quick_blog' in the current directory,
with a new rails application inside it. The '-T' option just means we don't include 'Test::Unit' files. [Test::Unit](http://test-unit.rubyforge.org/) is the default unit testing framework for Rails - though most developers prefer to use [RSpec](http://rspec.info/) instead, which is what we use in this blog.

**Start our local webserver**

~~~markup
rails server
~~~

Or 'rails s' for short. This launches the WEBrick web server, allowing us to access our app through the browser. WEBrick comes bundled with Ruby, making it the easiest webserver to use for our new blog.

Type `Control-C` to stop the server.

**Generate blog post files and migrations**

~~~markup
rails g scaffold Post title body:text
~~~

Short for `rails generate`. The `rails g` command can help us create controllers, views, models, and more.

The option we've gone with - *scaffold* - creates a full set including a model file, a controller file,  view files, some route defenitions, and a database migration file.

After *scaffold*, we specify the name of our model (Post), along with the *name:type* pairs we want as fields in our posts database table.

Since we don't specify a type for *title*, it will use the default type of *string*.

Lots more info on column types [here](http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/TableDefinition.html#method-i-column).

**Generate comments model, controller and routes**

~~~markup
rails generate resource Comment post:references body:text
~~~

We've opted for the longer `rails generate` option, but it's exactly the same as `rails g`. We've specified `resource` this time, rather than `scaffold`.

`resource` will generate all the same stuff as `scaffold`, except it'll leave out the view files. We don't need view files for Comments, because comments aren't viewed in their own right. To view comments, we'll manually add some code to our Post view files.

After `resource`, we specify the name of our model (Comment), followed by the name:type pairs we want as fields in the comments database table.

Note the `post:references` pair just says that a Comment should have a `post_id` foriegn key field.

### rake (short for 'Ruby Make')

Full doco [here](http://guides.rubyonrails.org/command_line.html#rake).

Rake helps with common admin tasks, like compiling asses, creating / updating databases, clearing temp data, and more. Most commonly, it's used for handling database migrations.

**Update the database based on your migrations files**

~~~markup
rake db:migrate
~~~

This looks at the files in your `db/migrate/` folder, and runs the appropriate migration files to get the database up to date.

Rails auto-maintains the `app/db/schema.rb` file, where it keeps track of which migration the database is up to.

After running this command, you'll need to restart the rails server (`Control-C` to stop, `rails s` to start).

**bundle exec**

If you're having to prefix your rake commands with **bundle exec**, see the explanation why [here](http://stackoverflow.com/questions/6588674/what-does-bundle-exec-rake-mean)

### git (version control)

Several git commands are used in the tutorial, but I won't go over git here. If you're not already familiar with git, you'd best learn it before writing another line of code, in any language!

Tower made a great [git cheat sheet](http://www.git-tower.com/files/cheatsheet/Git_Cheat_Sheet_grey.pdf).

### heroku

The heroku command line tool is used to interact with Heroku's server, to put our blog live, and publish changes. I've done a separate post covering the `heroku` commands. (ToDo - Add link here)
