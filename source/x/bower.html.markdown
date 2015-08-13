---
title: Bower
---

<h1>Bower</h1>

[Use bower with rails](http://dotwell.io/taking-advantage-of-bower-in-your-rails-4-app/)

Create .bowerrc with:

~~markup
{
  "directory": "vendor/assets/bower_components"
}
~~

Now create `bower.json` by running:

~~~markup
bower init
~~~

Answer the questions. Use `globals` for the question: `what types of modules does this package expose?`

In `/config/application.rb` make it look in your bower components for assets:

~~~ruby
config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
~~~

Now **Restart your rails server**

You probably DON'T want to add the bower components to your `.gitignore`. The asset pipeline needs them to be there in production - unless you want to install them with bower as part of your deployment process.

Now include your bower packages:

Javascript:

~~~javascript
//= require angular/angular
~~~

CSS:

~~~scss
*= require bootstrap/dist/css/bootstrap
~~~


A [good bower cheat sheet](https://github.com/sawmac/cheatsheet-bower)

[Search packages online](http://bower.io/search/)

~~~bash
bower --help

bower install jquery --save
#(save it to your bower.json)

bower install jquery --save-dev
#(save it to your bower.json, as a development-only dependency)

bower install jquery
# don't save to bower.json - just download it.

bower install jquery#1.11
#(specify version number)

bower search jquery
~~~
