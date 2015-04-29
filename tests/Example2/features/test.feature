Feature: Create User and login to test site

Scenario: Create new user and login to site
Given I have a user account
When I visit the test site
And I login using that user account
Then I am successfully logged in

Scenario: Login using an incorrect username
When I visit the test site
And I login with a test account that doesn't exist
Then I receive a login error
