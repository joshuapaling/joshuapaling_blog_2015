---
title: Elixir
---

<h1>Elixir</h1>

# Create new project
mix new cards

# Compiles your code and makes it available in the shell
iex -S mix

# recompiles your code to load changes into the shell
recompile


list comprehension: essentially a map

tuple: like a short array, where each index has a very special meaning (to the developer).
Eg {"joss", "paling"} - the dev remembers that the first element is always the first name, and the next the last name. Bit like a hash in ruby:
{ first_name: 'joss', last_name: 'paling'  }

pattern matching: is elixir's replacement for variable assignment

{:error, _reason} -> "That file does not exist"
The underscore indicates the var is just there for pattern matching; we won't use it.

mix docs # docs will be in ./doc/index.html
mix test

Maps are key-value pairs. Like hashes in Ruby:
colors = %{primary: "red"}

# use dot notation:
colors.primary # returns red

# Or with pattern matching:
%{primary: primary_color} = colors

# updating maps:
colors = %{primary: "red"}
Map.put(colors, :primary, "blue") # returns a new map
# or
%{ colors | primary: "blue" }

# Adding new key to map:
Map.put(colors, :secondary_color, "green")

Lists are like arrays - any length.
Tuples: like arrays, where each index has a special meaning
Keyword lists: combine these concepts.

colors = [{:primary, "red"}, {:secondary, "green"}]
# or with a syntax shortcut:
colors = [primary: "red", secondary: "green"]

This is an arbitraty data structure with a lot of special meaning in elixir.

colors[:primary] # "red"

Unlike maps, keyword lists allow you to have the same key more than once. Useful when eg. you're using Ecto and you want to have multiple `where` clauses.

# structs
structs are just like maps with 2 additional features:
1) can assign default values
2) have some additional compile-time properties - only properties that can exist are the ones we define.
Structs are for DATA only. Struct is just a map under the hood - can't have functions.

# strings

Elixir strings are nothing but a sequence of bytes.

Using « » syntax we are saying to the compiler that the elements inside those symbols are bytes.

~~~elixir
iex> string = <<104,101,108,108,111>>
"hello"
~~~