---
title: How to run a single CakePHP test case in the browser
tags: cakephp
---

The CakePHP Cookbook mentions that you can [filter test cases](http://book.cakephp.org/2.0/en/development/testing.html#filtering-test-cases) from the command line, so you don't have to run ALL tests every time.

What it doesn't mention is that it's easy to do the same thing in the browser.

So, if you're a CakePHP developer wondering how to filter test cases in the browser, or how to run only a single test case in the browser, all you need to do is add the `&filter=regularExpression` parameter on the end of your URL.

Let's say you had a `Task` model, and you want to test the `testAddTask` case only, without running through any other test cases in that file. Your URL would look something like this:

~~~markup
http://www.example.com/test.php?case=Model/Task&filter=testAddTask
~~~

Note that the `filter` parameter will take a regular expression. So, lets say you wanted to test only the cases that relate to delegating tasks. You can do something like:

~~~markup
http://www.example.com/test.php?case=Model/Task&filter=*Delegate*
~~~

to match all test cases with the word 'Delegate' in the method name.