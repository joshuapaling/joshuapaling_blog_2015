---
title: Vagrant Cheatsheet
tags:
published: false
layout: blog
---

Virtualisation: running one operating system within another operating system (eg what parallels does with mac and windows). Ie, run a virutal machine.

Vagrant doesn't provide virtual machines itself; it makes it easy to manage virtual machines through a selection of other providers (eg. virtual box)

Create new Vagrantfile based on latest ubuntu: `vagrant init ubuntu/trusty64`

The `Vagrantfile` is actually ruby code.

`vagrant ssh` - ssh into the machine.

`vagrant provision` - provision the server again, without starting from scratch

Good reasource: https://adamcod.es/2014/09/23/vagrant-ansible-quickstart-tutorial.html

https://24ways.org/2014/what-is-vagrant-and-why-should-i-care/