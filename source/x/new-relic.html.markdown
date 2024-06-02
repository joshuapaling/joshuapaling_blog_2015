---
title: New Relic
---

<h1>New Relic</h1>

New Relic log search does not support regex - see [slack discussion](https://luxgroup-hq.slack.com/archives/C01B1HZDZ7Z/p1714612806791419)
The best we can do is some basic matches like wildcard `*` and NOT with eg. `message:"Attempt*" -message:"Attempt 0*"` to find "Attempt, but not Attempt 0".

For number fields, use eg. `field:>500`

It's based on Lucene query language.
Query syntax for logs is [here](https://docs.newrelic.com/docs/logs/ui-data/query-syntax-logs/).

However you can do regex with RLIKE when using the Query Builder, and you can query logs with the Query Builder - [see example](https://onenr.io/0EjO9Mdy5w6).
So, paid users can effectively query logs via regex, using the Query Builder.

At LE we have log retention of 30 days.

We DO have New Relic logs in Big Query, and you can do regex search there.

~~~
# 50X responses in prod
 "env":"prod" responseCode:>=500
~~~
https://onenr.io/0oR8EOEWMjG

~~~
# Anything in test that has a stack trace
app:svc-order env:test stack:"*"
~~~

---

[Any deployment](https://one.newrelic.com/logger?account=2826932&begin=1691015904712&end=1691102304712&state=716ef9c1-c406-5ca8-4632-e2b027c07bf9)

~~~
Search logs for "running release"
~~~

---

[public offer 500 responses for a particular offer ID](https://one.newrelic.com/logger?account=2826932&begin=1691099406399&end=1691101206399&state=57a1b262-d1fe-fabb-3571-80c3c72b7ced)

~~~
tag:newrelic.prod-le-svc-public-offer-syd status:500 0062y00000CPKupAAH
~~~

Note the 500 responses only recognise the http response, and don't have a stack trace - they're not an exception (even though an exception resulted in the 500)

---

Errors in prod:

~~~
env:prod level:error
~~~

---

[all POST requests to svc payment prod](https://one.newrelic.com/logger?account=2826932&begin=1707960660000&end=1707982260000&state=a4a4f472-6b00-c56a-04bb-2cf474536de4)

~~~
env: prod tag:"newrelic.prod-le-svc-payment-syd" pid:"router" -http_method:"OPTIONS" http_method:"POST"
~~~

[all POST requests that errored](https://one.newrelic.com/logger?account=2826932&begin=1707960840000&end=1707982440000&state=bed58ac4-1282-5607-1ab0-dcb2cedfa3c6)


~~~
select max(numeric(memory_redis_bytes)) from Log where heroku_source like '%REDIS%' and team = 'flights' and env in ('prod') facet heroku_source, app limit max timeseries since  3 hour ago  COMPARE WITH 1 week ago
~~~

[Redis memory usage compared to previous week](https://onenr.io/0qQaPNPJVj1)


~~~
app:svc-order env:test "source":"heroku" "heroku_error_code":"H12"
~~~

[Heroku error code H12](https://onenr.io/0EjOnymMbR6)

~~~
SELECT average(numeric(load_avg_1m))  FROM Log WHERE app = 'svc-order' AND env = 'test' and message like '%load-avg-1m%' and message like '%postgres -%' TIMESERIES SINCE 3 day ago
~~~

[average postgres DB load](https://onenr.io/0bRmE6ylzRy). load_avg_1m is a [heroku metric](https://devcenter.heroku.com/articles/log-runtime-metrics#cpu-load-averages), refers to dyno load.


~~~
SELECT count(*) FROM Log WHERE `http_path_template` LIKE '%booking/departing%' SINCE 10 days ago TIMESERIES 1 day 
~~~

[Find queries to the path booking/departing](https://onenr.io/0bRKzyvekwE)