---
title: After InstallFest - Next Steps
tags: rails
---

<p class="lead">So, you've finished the InstallFest tutorial series. You're ready to stand on your own two feet, ditch the hand-holding, and move forward with good old fashioned Google and Persistence. Here's some suggestions on what to do next.</p>

## Most Important

Two things:

### 1. Finish the InstallFest tutorial. And understand it.
Hopefully you've already done that. But I've come across lots of people who gave up at step 2 or so. Persist to the end, and you'll have a pretty decent site.

### 2. Use your blog to... well... blog!
Make your blog your personal website, and actually write real blog posts. Write about everything. Blog about your errors and how you solved them. Blog about questions you had while learning rails, and the answers you came across later. Use. Your. Blog.

It doesn't matter if no one reads it. Heck... no one reads mine! It matters that you learn from the process of blogging, and that you've got your solutions / lessons / tips all in one place for your own future reference.

## And once you've done that...

Make incremental improvements to your blog. Just pick one tiny feature, and implement it. Then, pick another. Here are some suggestions:

### Easy

* Add a 'published at' date for blog posts, and order by that
* Display the author name, rather than email, for blog posts
* Get pagination working for your blog posts (hint, use the `kaminari` gem)
* Add 'edit post' links to your posts in the user-facing area of your site, only if the user is logged in. Hint: use this code:
~~~
<% if admin_user_signed_in? %>
  <%= link_to "Edit", edit_admin_post_url(post.id), target: :blank %>
 <% end %>
~~~

* Make your site responsive - create a sidebar with some info about yourself (or blog categories, if you want to create them), and make your site re-arrange on mobile devices using Foundation's grid
* Replace the built in comments with [Disqus](http://disqus.com/). I've got almost thousand spam comments on my blog - and you will too. Unless you want to build your own means of handling them all, just install Disqus comments. Don't forget to use migrations to delete your existing comments table.
* Change your .erb files to use [haml](http://haml.info/)

### Medium

* Create categories for your blog posts (Hint: the relationship between posts and comments is similar to the relationship between categories and posts. A post has one category, and a category has many posts).
* Do something involving image uploads - either add a 'featured image' to blog posts, or an 'image' for each author, or add a photo galleries section to your website. (hint: use the `carrierwave` gem)
* Add a means for logged in users to approve comments, or mark them as spam. (Note: this isn't needed if you just use [Disqus](http://disqus.com/) for comments)
* Make your blog posts sluggable
* Implement [Epic Editor](http://epiceditor.com/) for easy markdown editing. Trust me, this one makes blogging *much* more enjoyable.

### Harder

* Switch your development database from Sqlite to Postgres
* Get your blog live on a server other than Heroku, and start deploying with Capistrano
* Upgrade to Rails 4 - there's [a great screencast](http://railscasts.com/episodes/415-upgrading-to-rails-4?autoplay=true) on it.
* Make a spam filter for your comments (Hint: most spammers will try to put a link in their comments. If you reject comments with "href=", "href =", "url=" and "url =" you should cover most cases with a tiny bit of effort.)
* Implement categories such that a single post can belong to more than one category.
