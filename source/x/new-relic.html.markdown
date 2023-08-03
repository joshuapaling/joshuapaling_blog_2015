---
title: New Relic
---

<h1>New Relic</h1>

```
# Anything in test that has a stack trace
app:svc-order env:test stack:"*"
```


[Any deployment](https://one.newrelic.com/logger?account=2826932&begin=1691015904712&end=1691102304712&state=716ef9c1-c406-5ca8-4632-e2b027c07bf9)

```
Search logs for "running release"
```

[public offer 500 responses for a particular offer ID](https://one.newrelic.com/logger?account=2826932&begin=1691099406399&end=1691101206399&state=566c7377-b13d-68b1-3261-dee88bebba3e)

```
tag:newrelic.prod-le-svc-public-offer-syd status=5 0062y00000CPKupAAH
```

Note the 500 responses only recognise the http response, and don't have a stack trace - they're not an exception (even though an exception resulted in the 500)

[errors / exceptions containing a string](https://one.newrelic.com/logger?account=2826932&begin=1691079897362&end=1691101497362&filters=%28name%20LIKE%20%27support%27%20OR%20id%20%3D%20%27support%27%20OR%20domainId%20%3D%20%27support%27%29&state=25196d1e-2ee5-1103-ef1d-b404b65372d3)
```
app:svc-public-offer env:prod level:error unique_key
```