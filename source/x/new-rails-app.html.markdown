---
title: New Rails App
---

<h1>Stuff to do / remember when setting up a new rails app</h1>

- Use [spring](https://github.com/rails/spring), and springify binstubs

~~~bash
bundle install
bundle exec spring binstub --all
~~~

On spring's advice, I've installed [direnv](https://github.com/zimbatm/direnv#the-stdlib) so also add a `.envrc` file in the project root, with the content:

~~~bash
PATH_add bin
~~~

Use `bundle outdated` to check for outdated gems. See [http://stackoverflow.com/questions/6985945/bundler-how-to-check-if-gems-are-up-to-date](this) and [http://stackoverflow.com/questions/4696932/can-bundler-show-me-which-gems-in-gemfile-have-newer-versions-eg-dry-run-of-bu](this)
