---
title: Compass CSS3 background gradients not working in IE 10
tags:
---

I’ve been using [ColorZilla](http://www.colorzilla.com/gradient-editor/) to generate my background gradients, and I’ve been using the SASS / Compass version of the generated code, which looks something like this:

~~~scss
// needs latest Compass, add '@import "compass"' to your scss
background-color: #cccccc; // Old browsers
@include filter-gradient(#cccccc, #fafafa, vertical); // IE6-9
@include background-image(linear-gradient(top,  #cccccc 0%, #fafafa 100%));
~~~

I noticed it wasn’t working in IE 10, and on further investigation, the problem is actually that IE 10 is going by the WC3 standards (Gasp!) and Compass (following the implementation in other browsers) isn’t.

The current implementation of background gradients in most browsers is based on an old WC3 candidate recommendation, and looks something like a vendor-prefixed version of this:

~~~scss
background-image: linear-gradient(top, #cccccc 0%,#fafafa 100%);
// I will refer to this as EXAMPLE 1
~~~

Note the ‘top’ keyword, indicating that the defined gradient should start from the top and go to the bottom.

However, the CORRECT implementation of gradients, according to the updated WC3 candidate recommendation, and (http://blogs.msdn.com/b/ie/archive/2012/06/25/unprefixed-css3-gradients-in-ie10.aspx)[]as implemented by IE 10], is like this:

~~~scss
background-image: linear-gradient(to bottom, #cccccc 0%,#fafafa 100%);
// I will refer to this as EXAMPLE 2
~~~

Note, the `to bottom` replaces `top`, to indicate the direction of the gradient in terms of where it’s heading, rather than where it starts.

Compass generates CSS according to the old recommendation, for both the vendor-prefixed, and non-vendor prefixed lines of CSS. Further, it doesn’t generate any -ms- prefixed line, since IE 10 supports prefix-free background gradients. Well, IE 10 does support them – but only in the EXAMPLE 2 format. The EXAMPLE 1 format simply doesn’t work.

To make sure, you can look at [Compass’ demo page](http://compass-style.org/examples/compass/css3/gradient/) and you’ll notice that gradients which specify a direction other than the default are not working in IE 10 (as at 22/May/2013).

So… what about solutions?

##Solution 1:

If you’re using top-to-bottom gradients only, then you’re saved! Top to bottom is the default direction – both according to the latest WC3 recommendation, and the previous one. So, if you simply leave out the direction, like this:

~~~scss
@include background-image(linear-gradient(#cccccc 0%, #fafafa 100%));
~~~

then browsers on the old syntax will automatically assume ‘top’, and IE 10 will automatically assume ‘to bottom’. Too easy!

If you’re using directions other than top-to-bottom, however, that won’t work.

##Solution 2:

Just use the [ColorZilla Gradient Editor](http://www.colorzilla.com/gradient-editor/) and instead of copying the SASS / Compass version of the code, just copy the plain CSS version of the code. Or, if you like painful monotony, hand-write it yourself.

##Solution 3:

If you really hate having as many lines as Solution 2 creates, then create a mixin to add -ms- prefixes onto Compass’s background-images. The mixin will look like this:

~~~scss
@mixin background-image-with-ms($image) {
    @include background-image($image); // Compass default version, for everything but IE 10.
    background-image: -ms-#{$image}; // Vendor prefixes for IE 10.
}
~~~

Then, call your mixin just like you would the regular Compass background-image way:

~~~scss
@include background-image-with-ms(linear-gradient(top,  #cccccc 0%, #fafafa 100%));
~~~

Note that this mixin still includes the WRONG output for the non-prefixed version. But it will still work because the -ms- prefixed version supports the OLD syntax (as per Example 1), not the new syntax (Example 2). This WON’T neccessarily be future-compatible, however. Hopefully by the time we get to the future, Compass will have resolved this issue itself and we won’t need a work-around.

## Update: solution 4

You can use degrees to create a gradient at any angle. As mentioned by **uli** in the comments, you can use degrees to do straight up / down or left / right gradients, too. That'll solve our problem, and it'll work in all browsers.

~~~scss
top-to-bottom = 0deg,
left-to-right = 90deg,
~~~