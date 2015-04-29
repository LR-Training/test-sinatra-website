
Given(/^I have a user account$/) do
  $data = {}
  $data['user_name'] = 'User' + Time.new().to_i.to_s + '@example.org' # Create a random user name
  $data['user_password'] = 'password'

  rest_post_call('http://localhost:4567/add_user', $data)
end

When(/^I visit the test site$/) do
  visit('http://localhost:4567')
end

When(/^I login using that user account$/) do
  fill_in('username', :with => $data['user_name'])
  fill_in('password', :with => $data['user_password'])
  click_button('Sign in')
end

Then(/^I am successfully logged in$/) do
  expect(page.body).to match('Logged in')
end

When(/^I login with a test account that doesn't exist$/) do
  fill_in('username', :with => 'invaliduser@example.org')
  fill_in('password', :with => 'invalidpassword')
  click_button('Sign in')
end

Then(/^I receive a login error$/) do
  expect(page.body).to match('Unknown User')
end
