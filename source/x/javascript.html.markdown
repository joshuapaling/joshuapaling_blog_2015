---
title: Javascript
---

<h1>Javascript</h1>

[using promises in loops](https://blog.lavrton.com/javascript-loops-how-to-handle-async-await-6252dd3c795)

[Object.entries](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/entries) - Iterate through key/value pairs

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

## Don't convert an arrow function just to console log:

[here](https://twitter.com/thekitze/status/1029369487685021696)


## Execute main function if running direct from command line. Import it otherwise.

~~~
const myFunc = async function(mode = 'scheduled_vendors') {
  // do stuff...
}

module.exports = myFunc
if (require.main === module) {
  // file is being called directly from the command line, not required by
  // another module, so execute it
  let mode = process.argv[2]
  myFunc(mode).then(
    () => process.exit(0)
  ).catch(e => {
    console.log('error', e.message);
    process.exit(0);
  })
}
~~~