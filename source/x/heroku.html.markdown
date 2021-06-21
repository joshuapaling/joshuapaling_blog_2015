---
title: Heroku
---

<h1>Heroku</h1>

Bash session

~~~markup
heroku run bash -a test-www-ee-scoopon-syd
~~~

Run a command

~~~markup
heroku run yarn algolia:sync:native --app prod-svc-ee-offer-syd
~~~

tail logs

~~~markup
heroku logs -a test-www-ee-scoopon-syd -t
~~~

rollback

~~~markup
heroku rollback v54 -a prod-le-svc-discovery
~~~


connect to redis

~~~markup
heroku redis:cli -a prod-le-svc-vendor-syd
Connecting to redis-animated-94383 (REDIS_URL):
ec2-13-237-235-169.ap-southeast-2.compute.amazonaws.com:6479> FLUSHDB
~~~

see what's running and kill a dyno

~~~markup
heroku ps -a prod-le-svc-vendor-syd
heroku ps:kill scheduler.8377 -a prod-le-svc-vendor-syd
~~~

refresh a view on reporting DB (or just run any bit of SQL)

~~~bash
heroku psql -c "refresh materialized view vendor.ee_voucher_trxs" -a prod-le-svc-reporting-syd
~~~

Logs formatting: [https://brandur.org/logfmt](https://brandur.org/logfmt)

Find how many cores your heroku dyno type has:

~~~bash
▶ heroku run "grep -c processor /proc/cpuinfo" --app prod-le-svc-graphql-syd
Running grep -c processor /proc/cpuinfo on ⬢ prod-le-svc-graphql-syd... up, run.1612 (Private-M)
2
~~~
