---
title: How to make a dump of an sqlite database in Rails
tags: sqlite
---

1) Open Terminal, and `cd` into your app's `db` directory, where your sqlite database files are stored.

~~~markup
cd /path/to/rails_app/db
~~~

2) Run this command (obviously, you can change the parameters accordingly - the first is the name of your existing database file, and the second is the path to the dump file you want to create):

~~~markup
sqlite3 development.sqlite3 .dump > /Users/joshuapaling/Desktop/database.sql
~~~

Of course, this command isn't specific to rails. Just `cd` into the directory containing your database, or specify the full path to it as the first parameter of your terminal command, and you're good to go.
