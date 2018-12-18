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
