---
title: Javascript
---

<h1>Javascript</h1>

[Check if object has property](http://stackoverflow.com/questions/1894792/determining-if-a-javascript-object-has-a-given-property)

~~~javascript
if (x.hasOwnProperty('y')) {
  // object itself has the propery
}

if ('y' in x) {
  // object or it's prototype have the propery
}
~~~

[Pretty print an object for debugging:](http://stackoverflow.com/questions/130404/javascript-data-formatting-pretty-printer)

~~~javascript
var myArray = ['e', {pluribus: 'unum'}];
var text = JSON.stringify(myArray, null, '\t');
~~~

Toggle next:

~~~javascript
$('a.question').click(function () {
    $(this).next('.answer').slideToggle();
});
~~~

[Debugging node apps](https://nodejs.org/api/debugger.html)
`node debug myscript.js` (it'll pause on a `debugger`)
type `repl` at the debugger to execute code / inspect vars

## switch statement

~~~
switch (status) {
  case 0:
    // do something
    break
  case 1:
    // do something
    break
  default:
    // something else
}
~~~

Round a number:

~~~
// returns a string, so OK for presentation, not future calculations
(1.2345).toFixed(2)
~~~