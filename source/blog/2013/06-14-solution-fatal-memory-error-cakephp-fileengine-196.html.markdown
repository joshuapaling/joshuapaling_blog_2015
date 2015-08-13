---
title: Solution to Fatal error - Allowed memory size exhausted in CakePHP FileEngine.php on line 196
tags:
---

I just came accross this error in one of my CakePHP apps. I’m going to keep track of my debugging as I go here, for my own reference, and to improve the luck of any error-code-googlers out there.

In my CakePHP 2.3 app, every request, I’m getting the following error:

~~~markup
Fatal error: Allowed memory size of 33554432 bytes exhausted (tried to allocate 32 bytes) in /Applications/MAMP/htdocs/BIG/Employee_Management_Website/www/lib/Cake/Cache/Engine/FileEngine.php on line 196
~~~

Let’s open `/lib/Cake/Cache/Engine/FileEngine.php` and see what it’s trying to do (if you’re new to CakePHP, although you shouldn’t permanently change the core files, taking a look at them and adding temporary debug messages is not a problem – and the code is very well written and easy to read):

Line 196 of FileEngine.php is within the ‘read’ method. So, Cake is trying to read something from the Cache, but is running out of memory.

196 reads:

~~~php
<?php
$data = unserialize((string)$data);
?>
~~~

To debug, right before line 196, I added:

~~~php
<?php
echo $key." (end of key) ";
?>
~~~

So that will tell me every key that my app tries to read from the cache. The last key that gets printed out before the error message is displayed will be the one that causes the error – too easy!

Turns ou the culprit is: `cake_toolbar_cachecb15c56b604b708b46f1b0ae9142f278`

Sure enough, I take a look at app/tmp/cache/cake_toolbar_cachecb15c56b604b708b46f1b0ae9142f278 and it’s massive for a cache file – 3.9MB. It’s from CakePHP’s debugKit Toolbar.

First, I just deleted the file and then viewed a page in my site (to regenerate the cache file). After this request, the cache file is regenerated at a size of 168K. So, that page wasn’t a problem, but at some point, some request has made the cache file massive.

Now it’s just a matter of clicking around the site, doing the things I’ve recently been doing, and finding out which page causes the cache file to suddenly jump massively in size.

As it turns out it’s a work-in-progress page where I display several hundred records, each with several joined records, without pagination.

So, the solution is too easy: clean that page up, make it use pagination so it’s not making a million requests to the database. In the mean time, to avoid getting memory errors while I work, I can disable the debugKit toolbar, or just add the following line to my AppController’s before_filter method, to avoid getting memory problems as I work:

~~~php
<?php
ini_set('memory_limit', '-1');
?>
~~~

Make sure to remove the above line once the problem is resolved!!!