---
title: Nulls In Your Database
tags:
published: true
---

<p class="lead">TLDR; You should make all your database columns so they DON'T allow nulls - unless you have an explicit reason for needing nulls.</p>

Rails defaults to letting database columns have nulls. That is, if you use Rails migrations to create a new column, if you don't explicitly tell it otherwise, that column will be allowed to have null values. I, and I assume many people, have been tending to just go with this default most of the time.

This is a bad idea, and really, you should do the opposite: don't allow nulls, unless you explicitly need them. Nulls are generally a pain; if you have them, your code has to handle both the 'null' case, and the 'empty value' case - both of which very often mean the same thing in practice.

The official definition of null is something like "undefined or unknown". Null is best understood with some examples:

## An example of null, where you probably don't want nulls

Let's say we have a `people` table, with an `id`, `first_name`, `middle_name`, and `last_name` columns. Lets say we have data like:

~~~
1, 'John', 'Robert',  'Smith'
2, 'Fred',     null, 'Peters'
3,  'Sue',       '',  'Brown'
~~~

### In an ideal world

Let's have a look at the middle-name columns:

**Row 1** has a value of 'Robert'; we know that John's middle name is Robert.

**Row 2** has a value of null (ie, undefined or unknown). Fred might have a middle name, or he might not - we don't know.

**Row 3** has a value of '' (empty string). We know that Sue has no middle name - her middle name is an empty string. If we weren't sure wether or not Sue had a middle name, the column would hold null. The fact it holds an empty string means she doesn't have a middle name.

### In the real world

In the real world, very rarely is enough care taken in data collection / handling / entry to confidently distinguish between null and an empty value, as we just did in the last example. In the real world, the data for both Fred and Sue would be thrown in the same boat, which is "Maybe they don't have a middle name, but equally likely, they have one, and we just don't know it".

Since both `null` ans `''`, in practice, mean the same thing, we're better off just eliminating null as a value, and then we simply don't have to worry about that case. This would simplify our code:

~~~ruby
class Person
  # a bunch of other code would exist here

  # some super contrived example code, with null checking
  def print_middle_name
    if @middle_name == nil
      puts "don't know the person's middle name"
    elsif @middle_name == ''
      puts "middle name is blank - they might not have a middle name, or maybe we just don't know it"
    else
      puts @middle_name
    end
  end
end
~~~

becomes:

~~~ruby
class Person
  # a bunch of other code would exist here

  # some super contrived example code, without null checking
  def print_middle_name
    # We DON'T have to check for nulls here, because we know the database doesn't allow them
    if @middle_name == ''
      puts "middle name is blank - they might not have a middle name, or maybe we just don't know it"
    else
      puts @middle_name
    end
  end
end
~~~

In a rare case, such as if we were doing a project to discover how many people had middle names, and how that varied across cultures, then we might decide that our 'middle name' data would be high enough quality, and important enough, that we'd definitely want to distinguish between null and empty string, and therefore we'd want our `middle_name` column to allow nulls.

## Another example of null, where you probably don't want nulls

Booleans. We almost always want a boolean to have two possible values: true or false. If it allows nulls, you've instead got yourself three possible values: true, false or null. You almost never want nulls in a boolean column. A person either did agree to the terms and conditions, or they didn't. Not knowing if they agreed or not is useless!

## Another example of null, where you probably do want nulls

Consider we added a `height` column to our `people` table, which holds the person's height in centimeters. In an ideal world, a `null` height would mean we don't know the person's height, and a `0` height would mean "we do know the person's height, and it's 0 - they literally have no height".

Here's some data:

~~~
1, 'John', 180
2, 'Fred', null
3,  'Sue', 0
~~~

Now, similar to the last example, we know John is 180cm tall. We know that we don't know what Fred's height is (since it's `null`). Sue's height is 0. Does that mean she's 0 cm tall? Of course not - in practice, it means we just don't know her height. 0 probably shouldn't be in there in the first place, but heck, this isn't the worst data atrocity you'll come across in your programming career.

So what should we do here? Really, we'd probably want to make the database column allow nulls, and prevent it from allowing 0s. But we can't do that. Our application code could prevent people from entering 0s, but we can't prevent 0s at the database level. So, we're stuck having to handle the case of both 0 and null - both of which effectively mean the same thing: we don't know the person's height.

Now, we could be naughty here, and decide that we're just not going to disallow nulls, and that we'll treat 0 as our 'empty/unknown' value. If [Codd](https://en.wikipedia.org/wiki/Codd%27s_12_rules) saw us do that, he'd probably have a heart attack - an unknown height should be null, NOT 0! It's not semantically correct, and I'm certainly not recommending it as a best practice or anything, but I could imagine situations where disallowing null, and instead treating 0 as your 'unknown/empty' value, simply ends up easier to manage and more practical overall, since you only have to handle one 'unknown/empty' value case in your code, rather than two. This is true only because we KNOW that someone can't have a 0 height. If their height is 0, we KNOW it's just that it's unknown.

Most of the time, in a situation like this, I'd allow nulls and just deal with it.

## Another example of null, where you definitely do want nulls

Let's say we add a 'weekly_income' column to our table, and the values are:

~~~
1, 'John', 1000
2, 'Fred', 0
3,  'Sue', null
~~~

Assuming the data is accurate, We know John earns $1,000 a week. We know Fred earns no income - maybe he's a young kid, or a stay at home dad or something. We don't know what Sue's income is. She may earn no income, or she may earn $1,000,000 a week for all we know.

In this case, assuming the application itself is designed such that income isn't a required field, it's important to allow nulls, and we certainly can't treat nulls and 0 as the same. Let's say we were doing stats on how many people in our database earned above $500 a week. The correct answer should be 50% (since John does, Fred doesn't, and we don't count Sue because we don't know her income). If we treated 0 and null as the same, then Sue and Fred would be lumped in together, and our result would be a wildly inaccurate 33%.

Let's say, however, that income was a required field in our application - that on sign up, users must enter their name, and income, or the record won't be saved. In that case, since we know our application code will enforce no null values, we should also set up our database to prevent null values, too. Otherwise, our application code will kind of have to consider the possibility of null values existing in the database, even though it doesn't expect to ever find any. If we simply don't allow null values at the database level, our application code can completely confidently assume it will never have to deal with them, which is a good thing.

## Some other stuff about nulls

According to my Dad, somewhere in the SQL spec, when it's talking about nulls, it says "avoid nulls". So, avoid them when you can.

Also, some databases suck at nulls. For example, [Oracle doesn't handle null strings](http://stackoverflow.com/questions/203493/why-does-oracle-9i-treat-an-empty-string-as-null). Sybase does [some weird](http://infocenter.sybase.com/archive/index.jsp?topic=/com.sybase.dc36271_36272_36273_36274_1250/html/refman/refman246.htm) things with nulls vs empty strings. Nulls are just generally tricky.

[This stackoverflow answer](http://stackoverflow.com/a/965732/1373987) puts it well:

> The most significant reason for allowing NULLS is that there is no reasonable alternative. Logically, a NULL value represents "undefined". For lack of NULLS, you'll end up trying to specify a "dummy" value wherever the result is undefined, and then you'll have to account for said "dummy" value in ALL of your application logic.

## Summary

If you don't pay attention, Rails (and most frameworks, I imagine) will have you allowing nulls in all your database columns. So, pay attention. Don't allow nulls, unless you really need them.

To change existing columns in a Rails app to not allow nulls: [read this](http://stackoverflow.com/questions/5966840/how-to-change-a-nullable-column-to-not-nullable-in-a-rails-migration)

To add a col that doesn't allow nulls in a rails migration:

~~~ruby
add_column :my_table, :my_column, :integer, :null => false, :default => 1
# or
add_column :my_table, :my_column, :string, :null => false, :default => ''
~~~