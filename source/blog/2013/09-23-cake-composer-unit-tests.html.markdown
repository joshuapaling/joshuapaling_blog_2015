---
title: Runing CakePHP unit tests from Command Line when using Composer
tags: cakephp
published: false
---

When changing an app to use Composer for the CakePHP core, I came across this error when trying to run tests from the command line:

~~~markup
PHP Warning:  include(Cake/Console/ShellDispatcher.php): failed to open stream: No such file or directory in /example/Console/cake.php on line 28
PHP Warning:  include(): Failed opening 'Cake/Console/ShellDispatcher.php' for inclusion (include_path='/example/lib:.:/Applications/MAMP/bin/php/php5.4.4/lib/php') in /example/www/Console/cake.php on line 28
PHP Fatal error:  Could not locate CakePHP core files. in /example/www/Console/cake.php on line 29
~~~

To fix it, in your app's Console/cake.php file, change

~~~php
<?php
 $root = dirname(dirname(dirname(__FILE__)));
 ini_set('include_path', $root . $ds . 'lib' . PATH_SEPARATOR . ini_get('include_path'));
~~~

to

~~~php
<?php
 $root = dirname(dirname(__FILE__));
 ini_set('include_path', $root . $ds . 'Vendor' . $ds . 'pear-pear.cakephp.org' . $ds . 'CakePHP' . PATH_SEPARATOR . ini_get('include_path'));

~~~
