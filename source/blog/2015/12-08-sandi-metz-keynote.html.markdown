---
title: Summary of Sandi's Keep Ruby Weird keynote
tags:
published: true
layout: blog
---

Sandi Metz gave a [great keynote](https://www.youtube.com/watch?v=skG09s9S3Fc&feature=youtu.be) at [keeprubyweird.com](http://keeprubyweird.com/). You should watch it.

Here's a summary for my own future reference. She goes through 3 interesting psychological experiments, and then covers the take-home points with regards to software dev. Here they are:

## 1. [The Line Length Study (Asch on Conformity)](https://en.wikipedia.org/wiki/Asch_conformity_experiments)

A subject is asked to say which of 3 lines is the same length as a given "reference line". Several confederates to the left of the subject answer incorrectly. A third of subjects will answers incorrectly, although most do so knowing they're wrong, just to conform.

Add in just one confederate who answers correctly, and the subject will be much more likely to answer correctly (ie, conformity goes down).

In another variant, the subject is told he is late and must therefore write his own answer on paper rather than speak it out. Again, conformity goes down.

**The Take-home points:**

*Want conformity (ie, everyone give same answer)?*

* in groups of 3 or more
* elicit opinions publicly
* allow most authoritative people to speak first.

*Prefer diversity (ie, more than one idea to choose from)?*

* Record opinions privately before discussing publicly
* Ensure equal air time for all speakers

## 2. [The Electric Shock Study (Milgram on Obedience/Authority)](https://en.wikipedia.org/wiki/Milgram_experiment)

Stanley Milgram was interested in how easily ordinary people could be influenced into committing atrocities for example, Germans in WWII.

A "teacher" (the subject) would test a confederate in a different room on word pairs. The teacher is asked to give the student an electric shock of increasing strength for each wrong answer, using a machine with settings labeled from 15 volts (slight shock) to 450 (danger - severe shock).

If subjects resisted perpetrating another shock, they were prompted with:

* Prod 1: please continue.
* Prod 2: the experiment requires you to continue.
* Prod 3: It is absolutely essential that you continue.
* Prod 4: you have no other choice but to continue.

If they continued to resist, they could stop.

Despite what experimenters anticipated, two thirds of subjects continued though to carry out the highest level of shock, despite the student screaming in pain, and even when the student went dead silent at the higher shock levels.

Variants which decrease level of obedience are below:

<%= image_tag 'blog/2015/obedience.png' %>

The two main themes which decrease obedience are: decrease percieved authority, and increase closeness to victim / feeling of agency in subject.

**The Take-home points:**

*Want obedience?*

* Have hovering authority figure giving commands
* Isolate actor from victim (eg. don't let devs talk to users who are affected by bad software)
* Isolate actor from others who disobey (eg don't let devs talk to each other)

*Prefer independent thought? (ie, best ideas regardless of effects of conformity)*

* Be hands-off (increase distance to authority figures)
* Reduce distance to victim (devs talk directly to people affected by their decisions)
* Allow actor to collaborate with other independent thinkers

## 3. [The Smoke Filled Room Study (Bystander effect)](https://en.wikipedia.org/wiki/Milgram_experiment)

A subject waits, filling out a form, in a room full of confederates. Smoke starts coming out the vents. The confederates are instructed not to react at all. The subject just follows their lead. Even when the smoke alarm goes off, the subject stayed (for an average length of 13 minutes).

When placed alone in the same situation, subjects left the room quickly.

In a similar study, if someone lays hurt on the street, people will just pass by. But once one person stops to help, others will also stop.

**The Bystander effect:** *In an emergency, the more onlookers there are, the less likely it is anyone will come to your aid.*

This is like maintaining a gem, asking for help, and getting radio silence back.

**The Take-home points:**

*Want inaction?*

* Direct requests to a group.

*Want action?*

* Direct requests to an individual.

The opposite is also true; if you're aware of the bystander effect, you can break the conformity of the group and be the one who steps up. If you do volunteer to help, you make a new group and others will join it.

**As a species, we are hard-wired to conform, obey, and derive rule from the behaviour of others in the group. It is hubris to imagine you're immune to this rule. You're affected like everyone else. These tendencies lead us to act in groups, in ways that do not reflect our best selves as individuals. If you refuse to believe you'll be affected, then you're doomed to do so. The only way to combat these tendencies is to be aware of their existence. In order to be the best group we can be, each has to act as though they're the only one here.**