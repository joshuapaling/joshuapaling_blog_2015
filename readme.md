Blog url: http://joshuapaling.github.io/joshuapaling_blog_2015/

The markdown engine is http://kramdown.gettalong.org/ and has some extras.

Eg. you can put markdown inside html:

<p class='specialParagraph' markdown='1'>
**Another paragraph** which allows *Markdown* within it.
</p>

Install bower dependencies: `bower install`

Build and deploy:

~~~markup
be middleman build
be middleman deploy
~~~
