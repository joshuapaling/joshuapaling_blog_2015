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

Toggle next:

~~~javascript
$('a.question').click(function () {
    $(this).next('.answer').slideToggle();
});
~~~
