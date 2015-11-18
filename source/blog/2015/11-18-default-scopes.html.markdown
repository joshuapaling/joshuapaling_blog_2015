---
title: Never, ever, ever user Rails default scopes
tags:
published: true
---

I'm [not](http://rails-bestpractices.com/posts/2013/06/15/default_scope-is-evil/) [the](http://www.ombulabs.com/blog/ruby/rails/best-practices/why-using-default-scope-is-a-bad-idea.html) [first](http://stackoverflow.com/questions/25087336/why-is-using-the-rails-default-scope-often-recommend-against) [person](http://www.railszilla.com/default_scope-in-rails-is-bad/rails) to recommend against default scopes.

Just wanted to throw one more warning in the pot. My previous convention was that I would ONLY use default_scope for ordering:

~~~ruby
class Customer < ActiveRecord::Base
  default_scope -> { order('name ASC') }
end
~~~

Seems pretty harmless, right? Wrong.

I've spent the last few hours tracking down a bug. Turns out the cause is that when you do `Customer.last`, Rails orders by your default scope, if one exists. So, you don't get the last inserted record, you'd get (in this case) the last alphabetically ordered. You can work around it by using `Customer.unscoped.last` - but sooner or later, you will forget to do this, and it won't be fun.

Never, ever, ever use Rails default scopes.