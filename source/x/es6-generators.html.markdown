---
title: ES6 Generators
---

<h1>ES6 Generators</h1>

[https://egghead.io/lessons/javascript-send-messages-to-and-from-javascript-es6-generators](Egghead course on Generators)



~~~
function * createMyGen() {
  const val1 = yield 'test 1'
  console.log(val1)
  const val2 = yield 'test 2'
  console.log(val2)
}

const myGen = createMyGen()
// myGen is an instance of the generator; no code is executed yet.

const result = myGen.next()
// calling next will execute up til the next yield statement,
// and will return an object of the form:

console.log(result)
{
  value: '', // whatever's right of the yield
  done: false // or true
}

const result = myGen.next('value for the first var')

~~~

