---
title: Dividing percentages in Sass
tags:
---


Just now I was trying to divide two percentages in SASS (I’m relatively new to SASS). Basically, I had 7 columns for days of the week, and I wanted something like:

~~~scss
width: (100/7)%; // did NOT work
~~~

After a bit of searching, it turns out SASS already has it’s own percentage function. So, if you’re wondering how to divide percentages, or convert fractions to percent in SASS / SCSS, it’s as simple as:

~~~scss
width: percentage(1/7);
~~~

Too easy! And it’ll also work with variables and / or units with pixels, eg:

~~~scss
width: percentage(360px / 960px);
~~~
