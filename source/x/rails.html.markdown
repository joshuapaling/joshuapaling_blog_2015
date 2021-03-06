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

~~~ruby
# bypasses callbacks and validation
Model.update_columns(column: 'Value')

# does not bypass validation
Model.update_attributes(:field1 => "value", :field2 => "value2", :field3 => "value3")
~~~

<h2>Migrations</h2>

In mySQL, with certain settings, Text cols can't have a default value. So they must allow null and have default value set to false. Example migration converting varchar to text:

~~~ruby
change_column :employees, :asset_return_details, :text, null: true, default: nil
~~~

Create new table including fkey to courses table.

~~~bash
./bin/rails g model Post category:references col:string col:integer
# all col types:
# :primary_key, :string, :text,
# :integer, :float, :decimal, :datetime, :timestamp,
# :time, :date, :binary, :boolean, :references
~~~

example decimal migration, with precision and scale:

~~~ruby
# more at https://ariejan.net/2012/08/28/rails-migrations-decimal-precision-and-scale/
# allows up to 999.99
change_column :my_table, :my_col, :decimal, precision: 5, scale: 2

# change col to be null - http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-change_column_null
change_column_null :employee_sites, :employee_site_role_id, false
~~~

[All options for  field:type](http://stackoverflow.com/questions/4384284/rails-generate-model-fieldtype-what-are-the-options-for-fieldtype)

~~~
def change
  create_table :workout_substitutions do |t|
    t.references :user, index: true, foreign_key: true
    t.timestamps null: false
  end

  # Add unique index:
  add_index(:accounts, [:branch_id, :party_id], unique: true)
end
~~~

To add a fkey column to an existing table: see [here](https://stackoverflow.com/a/42056089/1373987)

migration only, no model generation:

~~~ruby
rails g migration drop_posts
~~~

and in the migration:

~~~ruby
drop_table :posts
remove_column :table_name, :column_name
rename_column :table_name, :old_column, :new_column
add_column :table_name, :column_name, :type, null: false, default: ''

add_reference(:products, :user, foreign_key: true) # creates user_id col, with proper fkey index

remove_reference :tasks, :employee, index: true, foreign_key: true
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

Then access it via your local IP, eg: `http://169.254.90.15:3000/` (Which you can find in System preferences -> network) or your bonjour address, eg `http://joshuas-mbp:3000/` or `http://joshuas-macbook-pro.local:3000/`

(as per [this answer](http://stackoverflow.com/a/28948293/1373987))


### &:thing

Example:

~~~ruby
def tag_names
  @tag_names || tags.map(&:name).join(' ')
end
~~~

[More info](http://stackoverflow.com/questions/1217088/what-does-mapname-mean-in-ruby)

### Rails logger

~~~ruby
Rails.logger.info('Cookies: ' + cookies.count.to_s)
~~~

### Routes

Additional routes on same controller

~~~ruby
resources :territory_masters, only: [:index, :update] do
  collection do
    get 'search'
  end

  member do
    get 'edit_employee'
    put 'update_employee'
    delete 'delete_employee'
  end
end
~~~