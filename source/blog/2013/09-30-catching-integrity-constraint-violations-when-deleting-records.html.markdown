---
title: CakePHP - Catching integrity constraint violations when deleting records
tags: cakephp
---

In a CakePHP app, if you've done the right thing and defined your Model associations at the database level (ie, if you've added foreign key indexes to all the relevant fields in every table), then you might come across errors when deleting records… something like this:

~~~markup
SQLSTATE[23000]: INTEGRITY CONSTRAINT VIOLATION: 1451 CANNOT DELETE OR UPDATE A PARENT ROW: A FOREIGN KEY CONSTRAINT FAILS
~~~

You'll want to catch that exception yourself, and ideally, display it nicely for your users.

Here's a quick method I wrote for `AppModel.php` that should do the trick. On the `beforeDelete` callback, it'll loop through the model's `$hasMany` associations, and for any that aren't listed as `'dependent' => true`, it'll check for linked records, and throw an exception if it finds any.

(Of course, `'dependent' => true` cases can be ignored, since those associated records will get deleted automatically)

Say you were deleting a Category that had Items, the exception message will look something like this:

~~~markup
THERE ARE ITEMS LINKED TO THIS RECORD.
~~~

So, here's the code to put in `AppModel.php`:

~~~php
<?php
public function beforeDelete($cascade = true) {
 $canDelete = true;
 foreach ($this->hasMany as $model => $details) {
 	if ($details['dependent'] !== true ) {
   if ($details['className'] == $this->name) {
    $ModelInstance = $this;
   } else {
    $ModelInstance = $this->{$details['className']};
   }
   $count = $ModelInstance->find("count", array(
    "conditions" => array($details['foreignKey'] => $this->id)
   ));
   if ($count) {
    throw new Exception( sprintf("There are %s linked to this record.", strtolower(Inflector::humanize(Inflector::tableize($model)))) );
   }
   if ($count > 0) {
    $canDelete = false;
   }
 	}
 }

 return $canDelete;
}
~~~

And here's what the relevant snipped might look like in your controller:

~~~php
<?php
try {
 if ($this->MyModel->delete()) {
 	$this->Session->setFlash('Record deleted', 'default', array(), 'good');
 } else {
 	$this->Session->setFlash('Record was not deleted. Unknown error.', 'default', array(), 'bad');
 }
} catch (Exception $e) {
 $this->Session->setFlash("Delete failed. {$e->getMessage()}", 'default', array(), 'bad');
}
return $this->redirect(array('action' => 'index'));

~~~
