---
title: Package installation errors when installing Ruby on Rails
tags:
---

So, at Step 5 of the tutorial, when I run:

~~~markup
rvm install 1.9.3
~~~

I get this output at the terminal:

*The “all good” part*

~~~markup
Searching for binary rubies, this might take some time.
No binary rubies available for: osx/10.8/x86_64/ruby-1.9.3-p429.
Continuing with compilation. Please read ‘rvm mount’ to get more information on binary rubies.
Installing requirements for osx, might require sudo password.
Already up-to-date.
~~~


*The error*

~~~markup
Installing required packages: automake, apple-gcc42, libyaml, readline, libxml2, libxslt, libksba, openssl….
Error running ‘requirements_osx_brew_libs_install automake apple-gcc42 libyaml readline libxml2 libxslt libksba openssl’,
please read /Users/joshuapaling/.rvm/log/ruby-1.9.3-p429/1368886724_package_install_automake_apple-gcc42_libyaml_readline_libxml2_libxslt_libksba_openssl.log
~~~


As advised, I check the log, which says:

~~~markup
[2013-05-19 00:18:44] requirements_osx_brew_libs_install
Error: No such keg: /usr/local/Cellar/automake
There were package installation errors, make sure to read the log.
Check Homebrew requirements https://github.com/mxcl/homebrew/wiki/Installation
~~~

I’m trying to resolve it by installing each of the required packages, mentioned in the terminal output, individually:

~~~markup
brew install automake
brew install apple-gcc42
brew install libyaml
brew install readline
brew install libxml2
brew install libxslt
brew install libksba
brew install openssl
~~~

All installed successfully. I saw this line:

~~~markup
Installing libksba dependency: libgpg-error
~~~

and had a split second of panic before realising that it wasn’t an error – just a dependancy with ‘error’ in it’s name!

Anyway, time to retry installing ruby 1.9.3:

~~~markup
rvm install 1.9.3
~~~

Seems to be going better than last time… Worked!

Now, back to step 6 of the tutorial: I made Ruby version 1.9.3 the default with:

~~~markup
rvm --default use 1.9.3
~~~

Then re-started the Terminal and did a quick check of the ruby version:

~~~markup
ruby -v
~~~

The output was

~~~markup
ruby 1.9.3p429 (2013-05-15 revision 40747) [x86_64-darwin12.3.0
~~~

Perfect! I was actually expecting it to be more painful than that.

Hope I help someone else having the same problem!