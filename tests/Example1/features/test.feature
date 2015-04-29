Feature: Create User on test site

Scenario: Create new user that doesn't exist
When I create a user
Then the user is successfully created

Scenario: Create new user that already exists
When I create a user which already exists
Then the user is not created
