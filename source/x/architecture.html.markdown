---
title: Architecture
---

<h1>Architecture</h1>

Architecture is about:

Responsibilities: What do I know?

Dependencies: What do I know about? Something else holds the details, but I know how that something else works, and I know about the interface it provides to clients like me. If it's API changes, I have to change.

Boundaries: What do I NOT know about? What are the things that are tempting to make me know about, but that will pollute the mental modal & make future changes harder? What searvices might I want to call, but should not call?

Really, architecture is about dependencies. But clearly defining responsibilities and boundaries helps you get the dependencies right.

Dependencies isn't about 'which direction does the http call go?', it's about 'who knows about what?' or 'who defines the contract, who accepts that definition'.

Figuring out what depends on what is best done through examples. Let's imagine our payment service, and Stripe. And consider two types of payments: one regular payment, where we send a request, and Stripe responds to that request immediately with pass/failed response. And another where we're using 3DS - the customer has to enter a pin code sent to their mobile, this can take a minute, and so stripe will send a response saying 'pending 3DS check', then let us know later that the 3DS check has passed, and that our payment is successful (or, the opposite - that it failed).

## immediate response scenario

We'll have a hard-coded reference to api.stripe.com in our codebase. We'll look at stripe's docs - stripe defines the endpoint and owns the contract - and call the endpoint in the right way. Stripe, as per it's docs, will respond.
This one is clear - we depend on Stripe. Stripe does not know about us, or the thousand other clients like us. It releases a new API version, and it's on all those thousand clients to update themselves. Stripe is the boss here.

## asynchronous response scenario (3DS)

### with webhooks

Stripe's docs say that they can send a webhook when the 3DS check is complete, and they'll call it, sending a request body that they define.
So, we go to Stripe's admin area and add a new webhook - say api.luxuryescapes.com/payments/stripe/webook
Stripe stores this in their database. Stripe's codebase has no reference to us - it's data to stripe. We choose to add or remove that data, stripe doesn't mind.
We make an http request to stripe, which kicks off the 3DS check. Once it's done, if we've chosen to define webhooks, stripe will call them, with the request body that it dictates, and it's on us to know what that request body will be.
So, even though HTTP requests flow both ways, we depend on stripe. Stripe does not depend on us, even though there's a webhook going direct from Stripe to us.

## with events

Say, rather than the webhook going direct from Stripe to our payment service, we configure the webhook to go to an event bus. (we might need a middleman to pass stripe's webhook on to the event bus, maybe transform it on the way, but let's ignore that for now). So stripe sends a webhook to the event bus. Then payment service subscribes itself to listen to that event from the event bus, picks it up from the event bus, and processes it.

The dependency relationship is the same here. Our payment service depends on stripe. Stripe does not depend on our payment service, or on the event bus. Stripe just sends a webhook and let's us say where to send it.
The event bus does not depend on stripe, or on our payment service. It depends on nothing. It just says 'anyone can send me events, I'll forward them on to anyone who subscribes to those events - but the rest is all on you. I don't know or care who is sending the events, or who is listening to them'.

The service that subscribes to an event, depends on the service who sends that event. The event bus in between handles retires and other handy things, and allows multiple clients to subscribe to the same event, but it's an implementation detail and doesn't fundamentally change the dependency relationship.

## with queues

Say our payment service had stripe send the webhooks to a queue. Then, if our payment service is overloaded, the queue can build up, and payment service can process the events from the queue later when it's less busy.
This queue eliminates the temporal or real-time coupling between stripe's webhook system and our payment service. Payment service can be down for a moment, and nothing is lost.

But the dependency relationship stays the same. Our payment service depends on stripe. Stripe does not depend on our payment service, or on the queue. Stripe just sends a webhook and let's us say where to send it.

