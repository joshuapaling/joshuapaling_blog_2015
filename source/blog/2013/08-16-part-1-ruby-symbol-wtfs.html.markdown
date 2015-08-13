---
title: Part 1 - Ruby :symbol WTF's
tags: ruby
---

This post is [part of a series](http://joshuapaling.com/post/rails-blog-in-15-weeks)

Shortly into [Part 1](http://www.reinteractive.net/posts/32-ruby-on-rails-3-2-blog-in-15-minutes-step-by-step) of the rails install fest series, you'll come across Ruby symbols. Symbols are those things prefixed by a colon, such as `:posts`, `:title` and `:body`, which we come across in our database migration in part 1.

This post very briefly explains symbols, from a practical perspective. In doing so, it glosses over some issues, so at the end, I provide some links for those who want the full story.

For reference, here's the migration code from [Part 1](http://www.reinteractive.net/posts/32-ruby-on-rails-3-2-blog-in-15-minutes-step-by-step), which makes use of symbols.

~~~ruby
class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
~~~

## What are Symbols?

Symbols are "immutable strings". That is, they're strings that can't be changed.

## How do symbols behave?

In order to get an initial grasp Ruby code involving symbols, just mentally substitute the symbol for a string. A Ruby symbol is NOT a string. However, the symbol `:posts` in Ruby would, in most cases, behave in a similar way to it's equivalent string, `'posts'`, in other languages such as PHP, Java, etc.

## Why not just use strings, then?

Two main reasons:

**1)** Symbols, being more simple than strings, take up less memory and perform better.

**2)** There are situations where you *want* an unchanging string. Think of, for example, a database field name, or a hash key (or an array key in PHP). They're pretty much like constants. You wouldn't bother creating a constant variable for referring to them, but you would always refer to them using the exact same string.

Let's compare a PHP array to a Ruby hash:

~~~php
// php array
<?php
$user = array( 'first_name' => 'Joshua' );
echo $user['first_name']; // outputs 'Joshua'
~~~

~~~ruby
# ruby hash
user = { :first_name => 'Joshua' }
puts user[:first_name] # outputs 'Joshua'
~~~

You may want to manipulate the *value*, ie, 'Joshua', but the *key*, 'first_name', never needs to change. You're only using it to access that exact key of the array/hash. It's just an identifier, and you don't care about it in it's own right. You never need to capitalise it, concatentate it, get it's length, etc.

It's a string that *shouldn't* be changed, so in Ruby, you make it a string that *can't* be changed - ie, a symbol.

## The Long Story

The topic of symbols has been covered in far more depth, by Rubyists far more knowledgable than myself. And though I've painted a picture of symbols as being almost exactly like strings, they're actually different under the hood, so to speak. Take a look at these resources:

[The Difference Between Ruby Symbols and Strings](http://www.robertsosinski.com/2009/01/11/the-difference-between-ruby-symbols-and-strings/)

[The Ruby_Newbie Guide to Symbols](http://www.troubleshooters.com/codecorn/ruby/symbols.htm)

["What is a symbol in Ruby?"](http://programmers.stackexchange.com/questions/24460/what-is-a-symbol-in-ruby) question on programmers.stackexchange.com

[Ruby-doc official Symbol page](http://www.ruby-doc.org/core-2.0/Symbol.html) - this is probably less useful that the links above.