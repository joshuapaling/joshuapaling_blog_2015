---
title: Ruby Conf Day 1 Wrap Up
tags: ruby
---

Rubyists across the globe will no doubt be flocking to my blog by the millions to read my wrap up of day 1. Not really. But [my business](http://www.bbldigital.com.au/) paid for my ticket, so I should make some notes or something.

Here's the talks I went to, and the main points I took home.

## 1. [What it is you really do?](http://hub.rubyconf.org.au/speakers/cameron-barrie/#talk) keynote by [Cameron Barrie](https://twitter.com/whalec)

**The beginning:**
Cameron wanted to do photojournalism, but upon seeing a random iphone user's pic featured on the cover of a major newspaper after the london bombings, and a couple of other similar incidents, decided he wanted to be creating the technology that allows that stuff to happen.

And the first part of the talk was an inspiring speil about the role of devs in making that kind of world-changing stuff possible.

**The middle:**
Dev is splitting in two: dev as a commodity (which is being shipped offshore, and with which we can't directly compete) and dev as a creative role (eg. original, bespoke solutions to tricky problems), which is what you've got to be doing.

The antisocial programmer locked in his basement banging the keyboard all night offers dev as a commodity, and has no future in programming as a creative endevour. (At least, not in a city with Sydney's living costs.)

*There shouldn't be a hard-drawn distinction between 'creatives' and 'developers'.*

**The end:**

If you don't stay on top of your game & latest tech, there's an inevitable erosion of skill level. It will work out fine in the short term, but will bite you soon enough. Having said that, don't jump onto a new tech cos it's cool (aka 'hipster driven development'). Find the right balance.

**Do** take on technical debt. But do so consciously, and with a plan to deal with it. And make sure the client is aware of it, and willing to pay to resolve it.

## 2. [Extreme Makeover- Rubygems Edition](http://hub.rubyconf.org.au/speakers/andre-arko/#talk) by [Andre Arko](https://twitter.com/indirect)

*A very rough summary, likely with technical errors, and not covering all the points of the talk:*

There are almost 100,000 uniquely named gems. Which means almost 750,000 total gem-versions. And they each have dependencies.

Currently, for `bundle install` to resolve dependencies, it has to download a blob with all that info, and it must download it from a server in the US, which sux in Australia. And cos it's all sent as a single blog, it's not like you can cache stuff and only download what's changed since you last ran `bundle install`.

The makeover will use a text file to store all the gem names / versions / dependencies info, which makes it far easier to cache and only download what's changed.

## 3. [Rack—A Framework to Roll Your Own](http://hub.rubyconf.org.au/speakers/nishant-modak/#talk) by [Nishant Modak](https://twitter.com/nishantmodak)

*A pretty technical talk, with lots of live coding, most of which I didn't follow very well. The main thing I did take home:*

* Rack basically converts an HTTP request into a consistently represented ruby object.
* There's a LOT of middleware stuff (rack, and more) involved before an HTTP requrest even makes it to Rail's routes.

Further reading: [Rack on Rails](http://guides.rubyonrails.org/rails_on_rack.html) and [Rebuilding Rails](http://rebuilding-rails.com/), and also [https://github.com/nishantmodak/chotu](Nishant's git repo, of what he built). And also [http://ruby.about.com/od/rack/a/What-Is-Rack.htm](What is rack?)

## 4. [The Parental Programmer](http://hub.rubyconf.org.au/speakers/amanda-wagener/#talk) by [Amanda Wagener](https://twitter.com/a_wagener)

How to manage parenting and programming:

* Either be working, or be spending time with kids. Don't even bother trying to double it up at the same time.
* It gets way easier as your kids get older. (Yay! My twins are only 10 months old, and I sure hope it gets a bit easier!)
* Regarding new tech, meetups, and open source, you've kinda got to take it easy for a few years. Pick just the best & most important stuff.
* Find a job with flexible hours / location

### That's only the first half of the day done... but it's bed time. Gotta get some sleep so I'm not useless tomorrow.