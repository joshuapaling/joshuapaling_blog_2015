---
title: Questions About Unit Testing
tags: testing
---

Before I started unit testing, back when I knew it was all the rage but just hadn't got around to learning it, or wasn't sure if it'd be worthwhile for me, I wrote down these questions. It took me a while to get round to it, but I finally wrote answers.

This post is intended for people who haven't done any unit testing, but are wondering if it's worthwhile learning for their particular work.

**TL;DR** Learn to unit test. Just do it. Once you've learned, you'll be able to judge whether or not it's worth it. If you do find that it really isn't worth it, you're not building anything complex enough, so it's lucky you did learn it, because it's time to push yourself a bit harder!

## 1. When I'm working on smaller sites, with basic CRUD functionality and next to no business logic, is unit testing worth it? (nothing seems to break without unit testing...)

**Short answer**: probably not.

**Longer answer**: it depends. You have to ask questions like:

Is the site set-and-forget? As in, will you build it once and rarely, if ever, update it?

Is the functionality of the site really so simple that you can manually go through and test just about everything in the user-facing area of the site, in 10 mins or so? Is it so simple that you can safely make changes without worrying about inadvertently breaking something?

Do you currenlty ever have issues with stuff breaking unexpectedly, in these kinds of projects?

You don't unit test for the sake of unit testing. You unit test to be overall better - more time efficient, more reliable, less bugs, less long-term technical debt, less of a challenge to make significant refactors, etc.

If the sites you're building are really so simple that you're not having issues with those things, well, fine. Don't waste time unit testing.

**But, having said that,** if that's the case, it sounds like it's time to push yourself and take on something a little more complex, in which case, you'll want to start testing!

## 2. How big / complex does an app need to be before you start unit testing?  And for big apps, should you unit test even the simple stuff like basic CRUD functionality, etc?

That's a matter of personal preference. Some with argue that you should aim for 100% test coverage, even of simple stuff. Others will claim that's ridiculous. Personally, I wouldn't test CRUD. As for things any more complex, I like to ask myself these questions:

* How likely is the code to change?
*  If it does change, how easy would it be to break something unintentionally? (Many people find this easier than you might think!)
* If something did break, how drastic would the consequences be?
* How many different people are likely to be working with this code in the forseeable future?

If the respective answers to these questions are something like "rarely", "not at all easy", "not at all drastic", "one or two", then writing tests might not be worth the time.

Testing isn't intended to make life harder. It's intended to make life easier in the long term for a little extra work in the short term. If the feature is really such that you most likely won't re-gain the time spent on writing tests for a feature, within the forseable future, then fine. Don't write tests.

But if you're not writing any tests, just write some! Once you've got a few under your belt, you'll be able to make the call yourself on what's worth testing, and what isn't.

## 3. I already test really thoroughly, and feel I'd still need to test just as thoroughly, manually, even if I did unit testing, just to help me sleep at night. How will unit testing help me?

You, my treasured soul, are going to L.O.V.E unit tests!

In the beginning, you may well feel the need to manual-test, too. But quickly you'll learn that a) your unit tests are doing the job, and b) they're doing so far more reliably and efficiently than you'll ever be able to.

Unit tests will also help you catch any of those evil cowboy coders when they change your code and break it, but don't bother to test.

Your life is about to get WAY better!

## 4. What about unit testing private methods? Should you make them public just so you can test them? It seems private methods are an easy thing to test where you can specify certain input cases and expect certain outputs. *(This was a question I had when I first started testing)*

No! Don't test private methods directly.

Test the FUNCTIONALITY and the CASES that pivate methods take care of, but through the interface of public methods. If a private method exists, it must be called somewhere by a public method. And testing that public method, under the right circumstances, will test the private method.

One of the times when unit tests are great is when you have a well-tested class, with many private methods, and you decide it's time to do a big refactor. If you've tested private methods directly, then you'll be having to write new tests each time you shuffle private methods around, and that's dangerous. Too much is changing at once.

Ideally, during a big refactor, the public methods of your class will be well tested, and you'll be able to shuffle around your private methods, refactor to your heart's content, break things, and then know everything's working again when all your tests pass again - without having to modify tests at all.

If you start testing private methods, your code becomes really closely tied to your tests, and it's a pain to refactor. So, test all cases that a private method takes care of, but do so through the lens of a public method that calls that private method under given circumstances.