---
title: Do you create FKeys on the database level?
tags: rails
published: false
---

[11:48:38] <JoshuaPaling>  Hi, just wondering what the done thing is in Rails… do you enforce your foreign keys on a database level? As in create an index and so on? Or do you just not worry about it at the database level and let Rails handle it all?
[11:48:53]   funburn (~mtuckerb@203-4-173-153.perm.iinet.net.au) left IRC. (Ping timeout: 248 seconds)
[11:48:58] <jrobeson>  i do it with actual foreign keys JoshuaPaling , but not everybody else does
[11:49:09] <JoshuaPaling>  ok thanks
[11:49:19] <jrobeson>  if you're interested in that, look at the foreigner gem
[11:49:26]   sdornan (~textual@50-0-136-222.dsl.dynamic.sonic.net) joined the channel.
[11:49:28] <JoshuaPaling>  thanks, will do
[11:49:35] <jrobeson>  potentially also immigrant (if you want to generate migrations for your exisitng relations)
[11:49:36]   bricker`away (~bricker@24-205-29-27.dhcp.nrwl.ca.charter.com) left IRC. (Ping timeout: 245 seconds)
[11:49:41] <sevenseacat>  i let rails handle it, im lazy
