---
title: Superclass method for DRY model joins in CakePHP
tags: cakephp
---

Sometimes in your CakePHP apps, you'll need to ditch the `Containable` behaviour, and use raw joins instead. The problem is, specifying joins across a few tables gets pretty verbose, and the code is anything but [DRY](http://en.wikipedia.org/wiki/Don't_repeat_yourself). Here's a little method for your AppModel to keep your joins brief and readable.

(update: I've made it even DRYer on the basis of [@savant's](https://twitter.com/savant) suggestions to allow multiple joins to be defined in one call, and to assume CakePHP conventions)

So, here's the superclass method, straight up. Put it in your AppModel.php. Be sure to read the comments, which describe how to use the method for non-standard cases.

~~~php
<?php
/**
 * Return a (verbose) joins array from the (shorthand) $joins param.
 * each element of $joins should consist of a key, representing the Model we already have,
 * and a value, representing the Model we are adding via this join
 *
 * When following CakePHP conventions, and when the model we already have is
 * the one containing the foreign key, only the model names are needed.
 * eg:
 * array(
 *  'Suburb' => 'Postcode', // joins suburb.postcode_id (foreign key) to postcode.id (primary key)
 *  'Postcode.subregion_id' => 'Subregion.id' // joins postcode.subregion_id to subregion.id
 *  // ^ Specifying column names will also work, but is optional
 * )
 *
 * When not following CakePHP conventions, or when the model we already have
 * contains the primary key and the model we are joining to contains the
 * foreign key, use ModelName.col_name notation
 *
 * eg.
 * array(
 *  'Suburb.id' => 'Employee.suburb_id' // joins suburb.id (primary key) to employee.suburb_id (foreign key).
 *  // ^ We specify column names, so it doesn't assume the foreign key is on the left.
 *  'Postcode.custom_col1' => 'Region.custom_col2' // Specify column names when not following CakePHP conventions
 * )
 *
 * This method assumes all joins have the same $type (ie, LEFT, RIGHT or INNER). If that is not
 * the case, you'll need to call it once per join type, and then merge the two
 * arrays which are returned.
 *
 * @param  array $joins shorthand array of joins, eg:
 * @param  string $type  'LEFT', 'RIGHT' or 'INNER'
 * @return array An array of joins suitable to pass to a Model find call.
 */
 public function joinArray($joins, $type = 'LEFT') {
 	$joinArray = array();
 	foreach ($joins as $fromStr => $toStr) {
   $from = explode('.', $fromStr);
   $fromModel = $from[0];

   $to = explode('.', $toStr);
   $toModel = $to[0];

   if (!empty($from[1])) {
    $fromCol = $from[1];
   } else {
    $fromCol = Inflector::singularize(Inflector::tableize($toModel)) . '_id';
   }

   if (!empty($to[1])) {
    $toCol = $to[1];
   } else {
    $toCol = 'id';
   }

   $join = array(
    'table' => Inflector::tableize($toModel),
    'alias' => $toModel,
    'type' => $type,
    'conditions' => array(
    	"$toModel.$toCol = $fromModel.$fromCol",
    )
   );
   $joinArray[] = $join;
 	}

 	return $joinArray;
 }
~~~

Here's an example of how to use it. It should be pretty self-explanatory, but basically we're joining Suburbs, to Postcodes, to Subregions, to Regions, to States. So, 4 joins, across 5 tables.

~~~php
<?php
// (in your Suburbs controller)
$joins = $this->Suburb->joinArray(array(
 'Suburb' => 'Postcode',
 'Postcode' => 'Subregion',
 'Subregion' => 'Region',
 'Region' => 'State',
));

$suburbs = $this->Suburb->find('all', array('joins' => $joins));
~~~


Below is what the same code would have looked like without our superclass method. As you can see, it's verbose, repetitive, and umm… WET? Not DRY, anyway. We've turned 35 lines of code into 7 more readable ones. WIN!

~~~php
<?php
// (in your Suburbs controller)
$joins = array(
 array(
 	'table' => 'postcodes',
 	'alias' => 'Postcode',
 	'type' => 'LEFT',
 	'conditions' => array(
   'Postcode.id = Suburb.postcode_id',
 	)
 ),
 array(
 	'table' => 'subregions',
 	'alias' => 'Subregion',
 	'type' => 'LEFT',
 	'conditions' => array(
   'Subregion.id = Postcode.subregion_id',
 	)
 ),
 array(
 	'table' => 'regions',
 	'alias' => 'Region',
 	'type' => 'LEFT',
 	'conditions' => array(
   'Region.id = Subregion.region_id',
 	)
 ),
 array(
 	'table' => 'states',
 	'alias' => 'State',
 	'type' => 'LEFT',
 	'conditions' => array(
   'State.id = Region.state_id',
 	)
 )
);

$suburbs = $this->Suburb->find('all', array('joins' => $joins));
~~~