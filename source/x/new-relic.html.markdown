---
title: New Relic
---

<h1>New Relic</h1>

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

[errors / exceptions containing a string](https://one.newrelic.com/logger?account=2826932&begin=1691079897362&end=1691101497362&filters=%28name%20LIKE%20%27support%27%20OR%20id%20%3D%20%27support%27%20OR%20domainId%20%3D%20%27support%27%29&state=25196d1e-2ee5-1103-ef1d-b404b65372d3) eg. in this case, "unique_key"

~~~
app:svc-public-offer env:prod level:error unique_key
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