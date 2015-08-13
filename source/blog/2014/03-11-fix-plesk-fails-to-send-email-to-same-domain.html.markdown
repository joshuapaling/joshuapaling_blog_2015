---
title: Fix - Plesk fails to send email to same domain
tags: plesk
---

I came across an issue where the server would send email fine, except if it was sending the email to the same domain as the website it was being sent from (eg. sending from the www.clientsdomain.com.au website to info@clientsdomain.com.au or similar). It wasn't the first time I've come across the issue, and also wasn't the first time I've forgotten what the fix was.

Turns out the problem is that, when an email server is enabled on the domain, it thinks it can deliver the email locally, without leaving the server. This is often not the case - eg. your emails might be hosted elsewhere, such as with Google Apps. If your emails *are* hosted elsewhere, then the attempt to deliver the email (using the local method) fails.

### Just diable the local mail server

The solution is simply to disable the local mail server for that domain. There's various ways to do that, depending on your set up. Running Plesk 11, I had to ssh in and execute `/usr/local/psa/bin/domain -u yourdomainname.com -mail_service false`. But the solution will differ depending on if you're using Plesk, cPanel, etc, depending on what version you're using, etc. Turning local mail off isn't the trickiest / most annoying part, though.

### Testing to ensure Plesk local mail is in fact disabled

The most annoying part is *testing* to ensure that it has been turned off successfully. In my case, I was testing a client website, and really didn't want to have to call the client up and check whether they'd recieved an email, each time I tested. So instead I told them to ignore the test emails, and I did the following:

### Set up a test URL that sends an email
First, set up a function that sends a single email to two addresses - one on the same somain, one on a different domain (eg. your own email address). Now, you can easily test sending an email, and can also easily check that it at least works for emails *not* on the same domain.

### Check the mail logs
Now, after each time you test, check the mail logs. For me, using Plesk 11, they were at `/usr/local/psa/var/log/maillog`.

You can download them to your desktop and open them in your own text editor with something like:

`scp username@yourserver:/usr/local/psa/var/log/maillog ~/Desktop/mail_log`

or, you can ssh into your server and tail them:

`tail -n 60 /usr/local/psa/var/log/maillog`

Lines get added to that log pretty quickly, so make sure to tail more than the default 10 lines. (*we tail 60 lines with the above command*)

Now, search for the results of your test email. If it's still **failing** and using the local mail servers, you should be able to find lines that look like the below. Note the 'problem' email in this example is *info@clientsdomain.com.au*, and your own 'non-problem' email is *you@gmail.com*. Note `local-handlers` versus `remote-handlers`. You can see below that it's still trying to use the local mail server to deliver to the problem address. This means you're still in trouble:

~~~markup
qmail-remote-handlers[15670]: Handlers Filter before-remote for qmail started ...
qmail-local-handlers[15669]: Handlers Filter before-local for qmail started ...
qmail-local-handlers[15669]: from=anonymous@yourserver.com
qmail-remote-handlers[15670]: from=anonymous@yourserver.com
qmail-remote-handlers[15670]: to=you@gmail.com
qmail-local-handlers[15669]: to=info@clientsdomain.com.au
~~~

Once you successfully turn local mail off, there'll be no more references to `local-handlers` and they'll instead be replaced with `remote-handlers`:

~~~markup
qmail-remote-handlers[17990]: Handlers Filter before-remote for qmail started ...
qmail-remote-handlers[17991]: Handlers Filter before-remote for qmail started ...
qmail-remote-handlers[17991]: from=anonymous@yourserver.com
qmail-remote-handlers[17991]: to=info@clientsdomain.com.au
qmail-remote-handlers[17990]: from=anonymous@yourserver.com
qmail-remote-handlers[17990]: to=you@gmail.com
~~~

### It's working!

Once you get log output looking like the above, you know it should be sending the email to your client correctly! Yay! Call them to confirm it isn't ending up in their spam or anything.

This example was for Plesk version 11, but the concepts should be transferable.

### And by the way...

A good time to check this is before (or immediately after) launch - not 6 months later when the client finally seems to realise they have't recieved any enquiries through the website, ever. (*Yep, this has happened to me, more than once, despite the fact I **always** insist they test multiple times, after the site goes live. And the fact that I send them a test, and ask them to reply to confirm.*)
