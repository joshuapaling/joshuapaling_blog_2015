---
title: Ansible Cheatsheet
tags:
published: false
---

**task:** is basically like a single bash command.

**playbook:** is a series of tasks to run on your server.

**module:** a built in way to do something - eg access a package manager or something

Playbooks contain plays. Plays contain tasks. Tasks call modules. Modules do the work.

Plays:
- contain tasks
- applied to subset of hosts

**handlers:** Tasks that get run after certain triggers. Always run at the end of a play, and only run once.

**variables:** allow you to change your config for different environments.

**facts:** info collected about each server - eg disk space, memory etc.