---
title: 2014 Development Goals - how did I go?
tags: programming
---

At the start of this year, I wrote a post about [my goals for the year](/post/my-2014-development-goals).

How did I go? Here's a point-by-point breakdown.

## In no particular order:

<h3 class="text-success">1. Have at least a few live Rails sites under my belt by 2015 ✔ </h3>

I've made:
[https://espionagesydney.com.au/](https://espionagesydney.com.au/)
[http://gobigorgolocal.com.au/](http://gobigorgolocal.com.au/)
One custom shop, that the client is taking a LONG time to populate. (Was done partly by me, partly by a contractor)
One more bigger site that will be released early next year.

So, only 2 live, but 1 more completed, and one in the pipeline. I'm calling that a check.

<h3 class="text-danger" markdown='1'> 2. Learn more about server admin, and have an automated solution for Rails hosting (probably learning [Chef](http://www.getchef.com/chef/) / [Vagrant](http://www.vagrantup.com/) etc from [Reliably Deploying Rails Web Apps](https://leanpub.com/deploying_rails_applications)) ✘</h3>

I've learned more, and did go through the book. But I'm not using an automated solution for server setup - more on that in the next point. (So this is a fail - though I'm happy with the outcome.)

<h3 class="text-success" markdown='1'> 3. Come up with a solution I'm happy with for hosting Rails apps that my business makes - probably [AWS](http://aws.amazon.com/) ✔</h3>

I've decided that *really, properly* learning server admin is too much for me to take on. I've got enough on my plate keeping on top of the rest of the stack.

So, for small, straight-forward apps we're using [Digital Ocean](http://digitalocean.com/) - one-click rails server setup, with minimal knowledge required.

For large, business-critical sites we're using [Anchor](http://www.anchor.com.au/). They're not cheap, but they're good. They know servers, so I don't have to.

It's not the solution I imagined, but I'm happy with it. Check.

<h3 class="text-success" markdown='1'>  4. Present something (that doesn't totally suck) at [Roro Syd meetup](https://github.com/rails-oceania/roro/wiki/rorosyd-topics) ✔</h3>

I presented at RORO, at DevHub, and at RailsCamp Perth. And I'm an accepted speaker for [Ruby Conf Australia](http://rubyconf.org.au/2015#speakers). While it's up to others to judge wether or not I sucked, I'm calling this one a big fat win.

<h3 class="text-success" markdown='1'>  5. Move from student to mentor at [Dev Hub nights](http://reinteractive.net/community/development_hub) ✔</h3>

I did this... it was pretty unofficial. I just started wearing the blue 'mentor' badge rather than the white 'student' one. I still take the opportunity to gain knowledge from seniors, but I'll also answer questions if they come my way. So I guess that's a half-hearted check for this goal?

<h3 class="text-danger" markdown='1'> 6. Carry out the [MicroCourses idea](http://joshuapaling.com/post/rails-camp-micro-courses) at a RailsCamp & Dev Hub ✘</h3>

Nope. Fail. I tried to get it going at DevHub, but basically, [the idea sucked](/post/my-microcourses-idea-sucked)

<h3 class="text-danger" markdown='1'>  7. Be involved as an organiser or mentor at some Rails community events (apart from Dev Hub) ✘</h3>

I mentored at Rails Girls - but that's it. Speaking to people who've organised events, it's a HUGE amount of work, and with my kids the age they are, I think I'll have to put this goal on the back burner for a few years.

Although I technically did mentor at one event, I'm calling this one a fail, because I'd aimed for more.

<h3 class="text-success" markdown='1'>  8. Write at least 6 blog posts on dev-related stuff ✔</h3>

Yeah, I did this. I'm not stoked on the quality. A lot of it is just unpolished stuff for my own reference. But that's a check.

<h3 class="text-danger" markdown='1'> 9. Make at least two screencasts (as in, a Ruby / Rails related ones) ✘</h3>

Fail. I've done zero, but there's still a bit over a month left in this year, so I'm going to try get this done.

<h3 class="text-success" markdown='1'>  10. Make a nice responsive admin area theme for Rails, and, ideally, make generators so it can be built easily for each new app. (Or find existing solution to do this - possibly [Rails Bricks](http://www.railsbricks.net/)) ✔</h3>

I'm just doing a basic theme with Bootstrap, and I'm happy with it. Nothing spectacular, but it works. I'm definitely confident with the decision not to use ActiveAdmin or Rails Bricks or similar.

I haven't made a generator, but I've [added bootstrap support](https://github.com/dhampik/rails-admin-scaffold/pull/8) to [Rails Admin Scaffold generator](https://github.com/dhampik/rails-admin-scaffold)

I may go further with generating my own admin theme, but for now I'm happy with what I've got. Check.

<h3 class="text-success" markdown='1'> 11. Make a commit to an open source Ruby / Rails gem. ✔</h3>

Check. I made PR's to a few gems:
[Spree Slider - tidy admin interface](https://github.com/spree-contrib/spree_slider/pull/1)
[Rails Admin Scaffold - add bootstrap option for views](https://github.com/dhampik/rails-admin-scaffold/pull/8) (It hasn't been merged yet...)
[Rails Footnotes - 4 PRs merged](https://github.com/josevalim/rails-footnotes/pulls?q=is%3Apr+is%3Aclosed+author%3Ajoshuapaling)


<h3 class="text-success" markdown='1'> 12. Make a few responsive websites using a CSS grid system. (I've done responsive sites manually before, but grids seem much easier!) ✔</h3>

Yeah. I've made admin interfaces with them. Not sure if I've done it for a frontend? Anyway, they're a bit over-rated. Good for an admin area, but to get a frontend looking super nice on devices of all sizes, it takes more than just a grid. Grids help get the easy stuff done I guess.

I feel I'm satisfied, and know when to use them, and when not to. Check.

<h3 class="text-success" markdown='1'>  13. Score higher on [the Joel Test](http://www.joelonsoftware.com/articles/fog0000000043.html), or at least [the web dev version of it](http://www.brandonsavage.net/adapting-the-joel-test-to-web-development/). (When I first found out about this test a couple of years ago, I was scoring embarrassingly low. I've moved up a decent amount, but there's still room to improve!) ✔</h3>

I know I've improved on some things, though I wish I'd recorded where I was at exactly in the beginning of the year. Check. But that's another blog post in itself.

## 9/13. Overall, I'm happy with that. Bring on next year!