---
title: Rspec
---

<h1>Rspec</h1>

Check page has selector (capybara)

~~~ruby
expect(page).to have_selector('.workout_tab')
# and to NOT have selector...
expect(page).to_not have_selector('.workout_tab')
# and with a count...
expect(page).to have_selector('.workout_additions .video', count: 4)
~~~

Some form sample code (all the selector things are the html element's ids):

~~~ruby
visit new_user_registration_path
fill_in 'user_email', with: 'fred@example.com'
select '01', from: 'user_cc_expiry_month'
check 'user_agreed_to_terms'
uncheck 'user_agreed_to_terms'
click_button 'Place Order'

# click on a div:
find("#my_div").click
~~~

## [Good cheat sheet](http://cheatrags.com/rspec-matchers)