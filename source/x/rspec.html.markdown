---
title: Rspec
---

<h1>Rspec</h1>

Run one spec:

~~~bash
rspec spec/features/sign_up_spec.rb:5
~~~

Check page has selector (capybara)

~~~ruby
expect(page).to have_selector('.workout_tab')
# and with a count...
expect(page).to have_selector('.workout_additions .video', count: 4)
~~~