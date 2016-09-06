---
title: ES6 Promises
---

<h1>ES6 Promises</h1>

## promises

[great video on promises](https://www.youtube.com/watch?annotation_id=annotation_1449687199&feature=iv&list=UUVTlvUkGslCV_h-nSAId8Sw&src_vid=QO07THdLWQo&v=obaSQBBWZLk)

Promises are a solution to callback hell. A promise represents a future value, and is a standard syntax for anything that has a delayed response (eg executing an ajax request, reading from the DB, etc).

A promise, once it has the value it needs (which takes some time to get), will either be resolved, or rejected.

If it's a promise, it has a `then` function. The `then` function is what should be done once the time consuming operation is finished and we have the value we need.

NOT QUITE TRUE: Whatever you return from a `then` function gets passed to the next `then`. If `then` returns a promise, it waits for the promise to resolve before firing the next `then`.

From: http://taoofcode.net/promise-anti-patterns/
Promises are meant to be chained - each call to then() returns a new promise. It is this promise that the next then() should be called against.


===

A promise wraps a value that may or may not be set yet - but will be set in the future.

A promise takes a single argument. That argument is a function, called the executor.
The executor is called (ie, executed) immediately by the promise, with two parameters:

1. a function to execute if the executor succeeds
2. a function to execute if the executor fails

The executor usually does something time consuming (eg an http request) in order to return a value. The resolve or reject functions are called when that time consuming operation fails.


`then` always returns a promise. Remember, `then` accepts a function as a parameter. If that function returns a promise, sweet, then will return (I think? check...) that exact same promise. If then returns anything other than a promise, that value is wrapped in a promise (which is immediately resolved)
