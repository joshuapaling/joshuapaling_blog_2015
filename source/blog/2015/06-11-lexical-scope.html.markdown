---
title: Lexical Scope
tags:
published: false
layout: blog
---

useful: http://stackoverflow.com/questions/1047454/what-is-lexical-scope

In this post, we're going to understand what "lexical scope" means. When understanding programming concepts, I find it's first often useful to clarfiy/understand the (non-programming-related) meaning of the words used to describe them. So, let's start with some definitions:

## Lexical

**Lexicon:** the vocabulary of a person, language, or branch of knowledge. *Eg. "the size of the English lexicon"**

**Lexical:** relating to a lexicon. IE, relating to the words or vocabulary of a language. *Eg. "lexical analysis"*

Remember, *language* in these definitions refers to regular, spoken languages - not programming languages.

So, someone's **lexicon** is basically the words they know - their vocabulary. Someone's **lexical knowledge** is basically "what they know about all the English words".

## Scope

**Scope:** the extent of the area or subject matter that something deals with or to which it is relevant. *Eg. "we widened the scope of our investigation"*

## Lexical Scope

Putting the two words together, *lexical scope* means something like: *the extent/area of a lexicon (ie, stuff in a language) that something deals with.*

## Lexical Scope in Programming

In programming, *lexical* refers to the "words" and constructs of a programming language, as opposed to a spoken language. And *scope* refers to the concept of scope we're familiar with in programming - eg. "local scope", "global scope", etc. Scope describes where a particular thing (variable, object, function, etc) is available.

There's a nice definition of lexical scope [here](http://whatis.techtarget.com/definition/lexical-scoping-static-scoping):

Lexical scoping (sometimes known as static scoping ) is a convention used with many programming languages that sets the scope (range of functionality) of a variable so that it may only be called (referenced) from within the block of code in which it is defined. The scope is determined when the code is compiled. A variable declared in this fashion is sometimes called a private variable.

The opposite approach is known as dynamic scoping . Dynamic scoping creates variables that can be called from outside the block of code in which they are defined. A variable declared in this fashion is sometimes called a public variable.

There's [an example](https://gist.github.com/mcary/1020737) of lexical vs dynamic scoping in Ruby - but this is wrong because Ruby is only statically (lexically) scoped.


[another good article](http://hoolihan.net/blog-tim/2009/02/17/static-vs-dynamic-scope/)

Note: static (or lexical) vs dynamic *scope* is NOT the same thing as static vs dynamic *typing*.