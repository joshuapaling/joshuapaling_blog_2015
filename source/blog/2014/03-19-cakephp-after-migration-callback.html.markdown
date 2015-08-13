---
title: After Migration Callbacks in CakePHP
tags: cakephp
---

Here's a little code snippet I never remember, and often find myself looking for in past projects. Figured it'd save me some time to paste it here.

Instantiate a model and execute some SQL (or do whatever you want) after a migraton has run:

~~~php
public function after($direction) {
 if ($direction == 'up') {
  $Event = ClassRegistry::init('Event');

  $query = "UPDATE events SET rsvp_date = early_date;";
  $Event->query($query);
 }
 return true;
}
~~~
