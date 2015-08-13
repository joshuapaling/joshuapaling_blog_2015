---
title: Ruby
---

<h1>Ruby</h1>

~~~ruby
# array contains element
['Cat', 'Dog', 'Bird'].include? 'Dog'
~~~

select subset of array:

~~~ruby
a = [2,7,5,4]
b = a.select { |x| x % 2 == 0 }
~~~

detect just returns the first value that satisfies the predicate, if any, nil otherwise. select returns all the values that satisfy the predicate. a.detect { p } is analogous to a.select { p }[0]

~~~ruby
[1,2,3,4,5,6,7].detect { |x| x == 3 }
# returns 3
~~~


## class << self idiom

ToDo - summarise  [this answer](http://stackoverflow.com/questions/2505067/class-self-idiom-in-ruby)

An example of code using this is [this](https://github.com/chargify/chargify_api_ares/blob/master/lib/chargify_api_ares/config.rb) and then from the users perspective, it's like this:

~~~ruby
Chargify.configure do |c|
  c.api_key   = "your_key_goes_here"
  c.subdomain = "test-site"
end
~~~

Splat operator: [more here](http://stackoverflow.com/questions/776462/where-is-it-legal-to-use-ruby-splat-operator)

~~~ruby
Bundler.require(*Rails.groups)
# Rails.groups will be eg. [:default, :test]
# and the splat in this context turns that array into
# a comma-separated argument list, equivalent to:
Bundler.require(:default, :test)

# the require method may look like this:
def require(*groups)
  # groups contains an array of the (potentially many) groups
  # passed in as separate arguments
end

# another example:
Order.by_items(item0, item1, item2)
# can instead be...
Order.by_items(*Item.find(:all, ...))

# another example - the following are equivalent:
do_stuff(arg1, arg2, arg3)
do_stuff(*[arg1, arg2, arg3])
~~~
