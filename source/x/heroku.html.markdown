---
title: Heroku
---

<h1>Heroku</h1>

Bash session

~~~markup
heroku run bash -a test-www-ee-scoopon-syd
~~~

tail logs

~~~markup
heroku logs -a test-www-ee-scoopon-syd -t
~~~

rollback

~~~markup
heroku rollback v54 -a prod-le-svc-discovery
~~~
