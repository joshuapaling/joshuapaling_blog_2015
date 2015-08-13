---
title: Solution to Passenger running as user 'nobody' and group 'nobody'
tags: rails
---

**The error:** *When setting up a Rails site with Passenger, you get the following message in your browser:*

*This web application process is being run as user 'nobody' and group 'nobody' and must be able to access its application root directory '/var/www/vhosts/mysite.com/httpdocs'. However this directory is not accessible because it has wrong permissions. Please fix these permissions first.*

Read on for an explanation and solution…

##My setup

I'm on a Media Temple DV 4.0, running CentOS 5.8. I'm using Passenger 4.0.10. Today is 7 Aug, 2013. If your setup is too far off mine, ignore this post!

##The explaination *(Or at least, here's what it was in my situation)*

There's a lot of detailed info [here](http://www.modrails.com/documentation/Security%20of%20user%20switching%20support.html), but my abbreviation of the situation is as follows.

The contents of the directory `/var/www/vhosts/mysite.com/httpdocs` were owned by user/group `root:root`. This was because I'd logged in as root and SFTP'd up the files. (Note to self: don't do that in future!)

Now, apache runs as the root user. However, passenger won't run as root, for security reasons. So what user does passenger run as?

The [passenger website](http://www.modrails.com/documentation/Security%20of%20user%20switching%20support.html) says: *to make a long story short: it will switch to the owner of the file config/environment.rb. […] We rely on the system administrator to set the correct owner on that file.*

The system adminstrator! That's us! So Passenger relies on us to make sure `config/environment.rb` has the right owner, but we've got it owend by `root:root`. FAIL.

Because Passenger won't run as `root:root`, it will just run as `nobody:nobody`.

##The Solution: *Just change the owner*

Find the owner/group of your Document Root (ie, your httpdocs folder, or equivalent) - the folder that contains your entire rails install. Then, recursively set everything inside that folder to be owned by the same user/group (assuming, of course, that user/group isn't `root:root`).

For me, it meant `cd`-ing into the correct directory, and then running:

~~~markup
chown -R my_user:psaserv ./httpdocs
~~~
(Obviously, you'll need to replace `my_user:psaserv` with your `username:groupname`)

I didn't need to re-start Passenger, Apache or anything else at this point. I was just able to refresh my browser and it worked.
