---
title: Test doubles
---

<h1>Test doubles</h1>

[summary of terms](http://searls.herokuapp.com/posts/2011-06-03-whats-wrong-with-rubys-test-doubles.html)

**Test double:** any of the below.

**Stub:** Stubs out a method and returns a pre-canned response. Eg: `when(panda.poke()).thenReturn('chuckle')`

**Mock:** a test double that can be configured to expect certain invocations in advance, raising exceptions if those interactions never occur.

**Spy:** a test double that records all of the invocations made against it, exposing some way to interrogate how it was interacted with after the fact
