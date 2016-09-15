---
title: ES6 Syntax
---

<h1>ES6 Syntax</h1>

~~~javascript
// Object shorthand
// Bonus 1: Defaults
function greet({ name, age = 30 }) {
  console.log(`Hello ${name}, you are ${age}`);
}

// Bonus 2: Remapping
const pets = [
  { name: "Max", age: 5, type: "Dog" },
  { name: "Mitten", age: 3, type: "Cat" },
];

const type = "VIEW"; // already using a var called type, need to remap during restructure

// Note type from pet is remapped onto breed because we still need the already in-scope type variable
pets.forEach(({ name, age, type:breed }) => {
  if(type === "VIEW") {
    console.log(name, age, breed);
  }
});
~~~

Template Strings:

~~~
`string text line 1
 string text line 2`

`string text ${expression} string text`
~~~