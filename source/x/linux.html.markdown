---
title: Linux
---

<h1>Linux</h1>

[Manage disk space](https://kb.mediatemple.net/questions/916/Managing+your+disk+usage#dv)

[ops school curriculum](http://www.opsschool.org/en/latest/introduction.html)

list disk space for files in directory `du -sh *`:

~~~markup
[root@sneakerology httpd]# du -sh *
184K	access_log
2.0M	access_log.1
1.4G	error_log
299M	error_log.3
0	ssl_access_log
0	ssl_error_log
4.0K	ssl_error_log.1
4.0K	ssl_error_log.2
0	ssl_request_log
0	suexec_log
4.0K	suexec_log.1
~~~

## Directories: [good full summary](http://linuxcommand.org/lc3_lts0040.php)

A directory in a Unix-like operating system is merely a special type of file that contains a list of the names of objects (i.e., files, links and directories)

**/etc** contains configuration files. All files in /etc should be text files.

**/var** contains files to which the system writes data during the course of its operation. [more](http://www.linfo.org/var.html)

**/bin and /usr/bin** These two directories contain most of the programs for the system. The /bin directory has the essential programs that the system requires to operate, while /usr/bin contains applications for the system's users.

**/sbin** contains executable (i.e., ready to run) programs. They are mostly administrative tools, that should be made available only to the root (i.e., administrative) user.
