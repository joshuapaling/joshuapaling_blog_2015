---
title: How to show latest products in Spree
tags:
---

For a spree project I'm working on, I needed a *latest products* page. Since I'm new to spree/rails, it took me a while, but it's super easy once you know how. Here's how it's done, for any other newbies wanting to display most recent products in spree.

## Create a Decorator for the Products Controller

According to the [Spree Guides](http://guides.spreecommerce.com/developer/logic.html), to customise logic, first up, we need to add a [decorator](http://kresimirbojcic.com/2011/12/01/decorators-in-ruby.html) for our products controller.

We can add our decorator anywhere inside the `app/controllers` directory, or a subfolder of it. The preferred place to add it is inside a `spree` subfolder. So, create `products_controller_decorator.rb` inside `app/controllers/spree/`, and add the following code:

~~~ruby
Spree::ProductsController.class_eval do
  def latest
    @products = Spree::Product.available.order('available_on DESC').limit(25);
    render "index"
  end
end
~~~

It's a pretty straight-forward method. We simply select 25 Products, and order them by `available_on`, descending. We use the `available` scope, to limit our selection to products which actually are available - so products with a future `available_on` date will be excluded.

We also specify that we want to render the `index` view for this page - so our *latest products* page will look the same as our regular *products index* page. If you don't want to use the index view, delete the `render index` line, and create a new view template at `app/views/spree/products/latest.html.erb`.

## Add a route for your Latest Products Page

Last but not least, we need to define a route for our latest products page. As it stands, when we try to access `www.example.com/products/latest`, spree assumes we're trying to show the product with name/slug of 'latest'.

Open up `config/routes.rb`, and add the following code up the top, just under the line `Www::Application.routes.draw do`:


~~~ruby
Spree::Core::Engine.routes.draw do
  match 'products/latest' => 'products#latest', :as => :latest
end
~~~

Now, our **latest products** page will be available at `www.example.com/products/latest`, and we can link to it in our view files with something like this:

~~~markup
<a href="<%= spree.latest_path %>">Latest Products</a>
~~~

That's it! We're all done, in just a few simple lines of code. But it would have been just as easy with Magento, right? ;)

### Add a page for products coming soon

I won't do it here, but it would be similarly easy to add a 'coming soon' page… you'd just have to use the same process as above, but fetch products where the `available_on` is after today's date.

#### EDIT:

Actually, it wouldn't be that simple to add a 'coming soon' page. See comment below from Rebecca Skinner: "Not as straightforward to add a 'coming soon' page - products that have an `available_on` date in the future are not public. And if you make them public, nothing to stop them being added to carts, and purchased."
