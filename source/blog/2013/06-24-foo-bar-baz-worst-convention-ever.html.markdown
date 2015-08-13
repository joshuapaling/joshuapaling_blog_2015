---
title: Foo Bar Baz – the worst convention ever
tags: programming
---

<div class="lead">
I’m going to go out on a limb here and say that the whole foo / bar / baz etc convention for use in examples is one of the dumbest things ever invented. When trying to describe a programming concept with an example, is another level of generic abstraction really what’s needed?
</div>

How about we all just come up with a simple example that provides real-world context, each and every time we need to.

Consider the following two examples for demonstrating string concatenation in php:

~~~php
<?php
$foo = 'baz';
$bar = 'qux';
$foobar = $foo . ' ' . $bar;
echo $foobar; // outputs 'baz qux'
~~~

Or alternatively, providing some real-world context:

~~~php
<?php
$firstName = 'John';
$lastName = 'Smith';
$fullName = $firstName . ' ' . $lastName;
echo $fullName; // outputs 'John Smith';
~~~

Which is easier to follow? Makes no difference? Well what if you were new to programming… which would be easier then?

Can’t we think of a simplest case example and put it into a ‘real’ context?

Now, here’s hoping this idea spreads, via all zero readers of my blog, and all of the two genuine followers I have on Twitter, to the entire programming universe, eliminating the use of foo, bar and baz forever after!