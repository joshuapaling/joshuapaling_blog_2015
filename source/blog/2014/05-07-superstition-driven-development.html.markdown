---
title: Superstition Driven Development
tags: programming, ruby
---

Being involved in the Ruby community, and in particular, being involved in helping newbies learn to code, I've often come across beginners who have fallen into a trap that I could only describe as "Superstition Driven Development".

Here's a contrived example:

*I need to print the time my blog post was created. Let's try this:*

~~~markup
<%= published_at(post) %>
~~~

*hmmm... nope. Let's try it with spaces*

~~~markup
<%= published_at post %>
~~~

*Damn. Let's throw an @ symbol in there, that sometimes works:*

~~~markup
<%= @published_at post %>
~~~

(Many iterations later)

*What if we try putting them the other way round?*

~~~markup
<%= post.published_at %>
~~~

*Yay, that works! But I have no idea how.*

Here's an analogy of what's just happened. Let's say someone's trying to learn lego. They want to put two pieces together, and they're going with the unfalliable method of Superstition Driven Lego.

First, they try mashing the two pieces together side-to-side. Nope. Then top-to-top. Nope. Then bottom-to-side. Nope. *(sooner or later...)*. Hey, top-to-bottom works! But I've got no idea how.

Failing to regognise the fundamental pattern that blocks only fit together top-to-bottom, they continue down the same trial and error path when they try to connect a third piece to the existing two.

**WRONG, WRONG, WRONG!!!**

But why do they fall into this trap? I think it's because we're feeding babies with shovels, we're throwing them straight in the deep end, we're teaching them to walk before they can... OK, you get the picture.

We're getting them to use a Framework before they know the basic building blocks of object-oriented programming.

In my mind, the fundamental building blocks of OO programming are:

* Classes / Objects (and their relationship)
* Methods
* Variables (including variable scope)

Only three things. (There's a few more - inheritance for example - but that can wait.)

Since a framework is basically a big collection of those things, you'd better be crystal clear on those fundamental building blocks before starting to learn a framework.

## What's the cure for Superstition Driven Development?

If someone wants to learn programming (actually, properly learn it) they should start with a project that has no framework. They should start with no gems. No HTML, no CSS, no Javascript. No browser.

They should start with only these things: a text editor, and a terminal window. And a whole bunch of `puts` statements.

Build something simple, self-contained, and object oriented.

Moving on from that, there will be guaranteed confusion unless they're crystal clear on those three building blocks of OO programming:

* Classes / Objects (and their relationship)
* Methods
* Variables (including variable scope)

## What should I do?

If you see someone practicing Superstition Driven Development, stop them. Encourage them to step back to basics. Encourage them to identify the fundamental building blocks involved, and to articulate the ways those blocks can be put together.

Once they do understand how those bits fit together, there'll never again need to try connecting the lego side-to-side.
