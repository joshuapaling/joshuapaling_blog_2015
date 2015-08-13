---
title: Rails
---

<h1>Rails</h1>

<h2>Models</h2>

~~~ruby
class User < ActiveRecord::Base
  has_many :tasks
end

class Task < ActiveRecord::Base
  belongs_to :user
  default_scope { order(sort_order: :asc) }
  scope :published, -> { where(published: true) }
end
~~~

using models:

~~~ruby

User.find(id)
User.where(email: 'joss@bbl.com').first
~~~

<h2>Migrations</h2>


Create new table including fkey to courses table.

~~~bash
./bin/rails g model Post category:references col:string col:integer
# all col types:
# :primary_key, :string, :text,
# :integer, :float, :decimal, :datetime, :timestamp,
# :time, :date, :binary, :boolean, :references
~~~

[All options for  field:type](http://stackoverflow.com/questions/4384284/rails-generate-model-fieldtype-what-are-the-options-for-fieldtype)


migration only, no model generation:

~~~ruby
rails g migration drop_posts
~~~

and in the migration:

~~~ruby
drop_table :posts
remove_column :table_name, :column_name
rename_column :table_name, :old_column, :new_column
add_column :table_name, :column_name, :type, :null => false, :default => ''

add_reference(:products, :user, foreign_key: true) # creates user_id col, with proper fkey index
~~~

More [here](http://edgeapi.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-add_reference)

run it / roll back:

~~~markup
rake db:migrate
rake db:rollback RAILS_ENV=test
~~~

<h2>Views</h2>

~~~ruby
# render _my_partial.html.erb
<%= render 'my_partial', my_var: my_var %>
~~~

Image url in rails with sprockets:

~~~scss
background: transparent image-url('asterix.png') no-repeat center center;
~~~

<h2>Misc</h2>

~~~ruby
Post.all.to_json # returns a string
Post.all.as_json # returns an array of hashes
Posts.all.to_json == Post.all.as_json.to_json # true - they are the same.
~~~

~~~ruby
if Rails.env.development?
~~~

~~~ruby
# relative path to file
redis_config_path = File.expand_path("../../../../app/Config/redis_database_numbers.json", __FILE__)
~~~

<h2>When to restart rails server</h2>

The general rule of thumb here is making changes to anything outside of app/ or config/routes.rb will require a restart. [more](http://stackoverflow.com/questions/17729345/when-do-i-need-to-restart-server-in-rails)

<h2>View Rails site from other device over local network:</h2>

~~~
rails server -b 0.0.0.0
~~~

Then access it via your local IP, eg: `http://169.254.90.15:3000/` or your bonjour address, eg `http://joshuas-macbook-pro-2.local:3000/`

(as per [this answer](http://stackoverflow.com/a/28948293/1373987))
