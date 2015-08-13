---
title: Declare your javascript functions as variables
tags: javascript
---

Just sharing a quick tip I recieved at the last [Ruby on Rails Dev Hub](http://reinteractive.net/community/development_hub): declare your javascript functions as variables.

Rather than declaring your javascript functions like this:

~~~javascript
function sayHello($name){
 alert('hello ' + $name);
}
~~~

declare them as variables, like this:

~~~javascript
var sayHello = function($name){
 alert('hello ' + $name);
}
~~~

Of course, the two above snippets essentially do the same thing.

The reason for using the later is simply to remind yourself that javascript has [first-class functions](http://en.wikipedia.org/wiki/First-class_function). That is to say, functions can be assigned to variables, returned from methods (just like other variables can be), and passed into other functions as parameters (again, just like any other variable).

So, since functions are like other variables in javascript, you might aswell write your code in a way that reminds you of this!

While I'm at it, a few definitions and other tidbits worth knowing:

[First-class function](http://en.wikipedia.org/wiki/First-class_function): A language is said to have first class functions if it treats functions as first-class citizens.

A [First-class citizen](http://en.wikipedia.org/wiki/First-class_citizen) is something which supports all the operations generally available to other entities - eg. being passed as a parameter, returned from a function, and assigned to a variable.

(So, because functions can be treated just like other variables in Javascript - passed as parameters, assigned to variables, and returned from functions, functions are *First Class Citizens* in Javascript. That is to say, Javascript has *First Class Functions*)

[Functional Programming](http://en.wikipedia.org/wiki/Functional_programming) is a style of programming that avoids state. In functional programming, the idea is that everything is done using functions, and functions are little isloated islands of code that do one thing, and have no side effect.

The opposite, if you want to call it that, is imperative programming, where state is changed often - eg. a class is instantiated with instance variables and so on, and methods in that class change the state of that instance; the methods are not completely isolated and self-contained, they have side effects.

And just to clarify, the difference between a *function* and a *method* is that a method belongs to an object (that usually just means a method is declared within a class, if you prefer to think of it that way). A function does not belong to an object - it is its own self-contained thing. Some programming languages only have methods, some only have functions, and some have both.
