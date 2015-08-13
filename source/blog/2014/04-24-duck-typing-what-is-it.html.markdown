---
title: Duck Typing - What is it?
tags: ruby
---

Duck Typing is a bit of a buzz word. If you don't know what it is, it's likely that you've used it, or at least read code that uses it, without knowing it.

There's a million posts on duck typing. Most try to get all meta and use an example of a class called "Duck", which does nothing to help explain the concept. This post is what I wished I could read straight up.

## Duck
The first word of *duck typing* is a reference to the phrase "If it walks like a duck, and quacks like a duck, it's a duck". That'll make more sense as we go.

## Typing
The second word of *duck typing* refers to the type of an object. Consider the code below:

~~~ruby
first_name = "Fred"
# 'first_name' is an object of type String

test_scores = [97, 45, 86]
# 'test_scores' is an object of type Array

birthday = Date.new(2001,2,3)
# 'birthday' is an object of type Date
~~~
The *type* refers to the class that an object is an instance of.

## Duck + Typing

[Wikipaedia](http://en.wikipedia.org/wiki/Duck_typing) states: "In duck typing, a programmer is only concerned with ensuring that objects behave as demanded of them in a given context, rather than ensuring that they are of a specific type."

So, when we're 'duck typing', then we're not concerned with exactly what type of object we have (String, Array, Date, etc). If it behaves like the object we want for our specific purposes, then that's good enough. (If it 'talks like a duck', it's good enough.)

**That will make a LOT more sense after an example.**

## A Contrived Example

Let's say we want to implement a method, `show_length` which will tell us how long a string is. Eg:

~~~ruby
name = "Joss"
show_length(name)
# output: "It has a length of 4"
~~~

First we will NOT use duck typing, then we'll show the same example using duck typing.

### NOT duck typing

~~~ruby
def show_length(object)
  if object.class == String
    puts "It has a length of #{object.length}"
  elsif
    puts "You passed a #{object.class}. We wanted a String."
  end
end
~~~
Note that we **strictly check the type of the object passed in**. This is **NOT** duck typing. So, example input / output would be as follows:

~~~ruby
show_length("Fred")
# Outputs: It has a length of 4

show_length([1, 2, 3])
# Outputs: You passed a Array. We wanted a String.

show_length(Date.new(2001,2,3))
# Outputs: You passed a Date. We wanted a String.
~~~

But maybe it was overkill to enforce that the parameter was a String. When we passed in the array, it should have just told us the length of the array. In fact, lets not bother checking the type of the object at all; if it responds to the `length` method, it's good enough for us. (If it walks like a duck, and quacks like a duck, it's a duck.)

So, let's use duck typing...

### Using Soft Duck Typing

~~~ruby
def show_length(object)
  if object.respond_to?(:length)
    puts "It has a length of #{object.length}"
  elsif
    puts "You passed a #{object.class}. We wanted something with a length."
  end
end
~~~
Note that we **DO NOT check the type of the object passed in**. So, example input / output would be as follows:

~~~ruby
show_length("Fred")
# Outputs: It has a length of 4

show_length([1, 2, 3])
# Outputs: It has a length of 3

show_length(Date.new(2001,2,3))
# Outputs: You passed a Date. We wanted something with a length.
~~~
See how we don't check the type of the object; we just check that it's good enough for this particular context. If it responds to the `length` method, it'll do.

As [Wikipaedia](http://en.wikipedia.org/wiki/Duck_typing) states: "In duck typing, a programmer is only concerned with ensuring that objects behave as demanded of them in a given context, rather than ensuring that they are of a specific type."

In this context, we just care that we can display the object's length. We don't care about the specific type of object.

Note that in this example of *soft duck typing*, we do at least check that the parameter passed in has a `length` method. We might decide we want to save ourself a few lines, and just assume the caller will pass the correct thing.

Let's do that now...

### Using Hard Duck Typing

~~~ruby
def show_length(object)
  puts "It has a length of #{object.length}"
end
~~~
That's concise! We **perform NO CHECKS on the object passed in**. We just assume it'll have a `length` method. So, example input / output would be as follows:

~~~ruby
show_length("Fred")
# Outputs: It has a length of 4

show_length([1, 2, 3])
# Outputs: It has a length of 3

show_length(Date.new(2001,2,3))
# Gives a NoMethodError, since Date's don't have a length
~~~

## Real Life Examples

Now you know the basics, [this blog post](http://blog.rubybestpractices.com/posts/gregory/047-issue-15-duck-typing-2.html) has some great examples of duck typing applied in real life scenarios.
