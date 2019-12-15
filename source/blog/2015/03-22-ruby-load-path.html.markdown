---
title: Ruby Load Path
tags: ruby
published: true
layout: blog
---

A summary of [this video](http://www.sitepoint.com/loading-code-ruby/) for my future reference.

`require` is a kernel method. When you require files, ruby looks in the `$LOAD_PATH` global variable (it's also available in `$:`).

`$LOAD_PATH` is an array of absolute paths.

Let's say we have `shape.rb` and `triangle.rb` inside a folder. The following `require` will not work because the current directory isn't in `$LOAD_PATH`:

~~~ruby
  # shape.rb
  class Shape
  end
~~~

~~~ruby
  # triangle.rb
  require 'shape.rb'
  class Triangle < Shape
  end
~~~

If you add the relative path to require, it'll work:

~~~ruby
  # triangle.rb
  require './shape.rb'
  class Triangle < Shape
  end
~~~

But if you look at gem source files, they don't specify relative paths.

You can use the `-I` option to specify the current direct as the load path when loading a ruby file. Even without the relative path, this will work:

`ruby -I . triangle.rb`

Alternatively, we could add the current directly to the load path within our ruby file, before the `require` statement (note that the '.' refers to the Ruby process' current working directory, not the directory of the source file. So it'll only work if you're running ruby from the same directory as the file.):

~~~ruby
  # triangle.rb
  $LOAD_PATH.unshift('.')
  require 'shape.rb'
  class Triangle < Shape
  end
~~~

You could instead use `require_relative` method to specify files relative to the source file:

~~~ruby
  # triangle.rb
  require_relative 'shape.rb'
  class Triangle < Shape
  end
~~~

But this is rarely used because there's a better way. Ruby Gems are just source code heirarchies installed in a directroy that ends up in `$LOAD_PATH`. It's detailed around the 4m mark in the above video.

The `__FILE__` constant (aka, the double underscore file constant) stores the relative path to the current file.

So, you can do this:

~~~ruby
  # triangle.rb
  lib = File.expand_path("../../lib", __FILE__)
  $:.unshift(lib)
  require_relative 'shape.rb'
  class Triangle < Shape
  end
~~~

Note that a single `..` refers to the same directory - so `../../` only goes one level up, not two. So here, we add the lib directory to the load path.


<h2>load vs require</h2>

If you `require` a file more than once, it won't work the second time. This helps to prevent stuff like re-declaring constants. `load` loads the file every time you call it.

Metaprogramming Ruby book says:

<blockquote>
You use load() to execute code, and you use  require() to import libraries.
</blockquote>
