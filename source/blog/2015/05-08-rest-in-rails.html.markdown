---
title: REST in rails
tags:
published: false
---

http://martinfowler.com/articles/richardsonMaturityModel.html

Related: RESTful Fever: http://notes.jerzygangi.com/it-is-okay-to-make-non-restful-controllers-and-routes-in-rails/
(I think the more kinda 'specific' a page is to your application, the more it's like a crucial point in your app, the more likely it will be that REST might not fit)

- my users controller in BIG
- https://twitter.com/joshuapaling/status/596440224026259456
- http://www.shopify.com.au/technology/5898287-restful-thinking-considered-harmful

Design patters aren't king. Readable, maintainable code is king. Design patters are useful only to the extent that they help you create readable and maintainable code. If you think rigidly following a design pattern is leading you down a path of convoluted, hard to understand code, you're likely right! Back your own judgement and intuition.

REST is not like a simple, straight forward, self-contained thing or concept. It started with a full dissertation. People have opinions on it - on what's important to make code RESTful and what isn't. So, it's hard to find one definitive guide.

In practice, as far as I can gather, in the rails world, people most often use it to refer to
a) limiting your controllers to the standard CRUD actions (show, new/create, edit/update, destroy)
b) having your controllers named after "nouns", so a "resource" (which is a noun) is exposed through a controller, which provides some subset of CRUD.

Examples:
preseason page of TMC - NON-restful, and should stay that way (consider the alternative!)
BIG users controller: NON-restful, but should NOT be that way
DEVISE - RESTful, and correctly so (think of how many extra actions you'd have if it wasn't RESTful)
