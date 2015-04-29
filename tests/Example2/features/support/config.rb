require 'open-uri'
require 'net/http'
require 'rspec/expectations'
require 'json'

require 'capybara/cucumber'

### Allows you to use the page. commands
include Capybara::DSL

### Configures Capybara to use Xpath selectors and use poltergeist driver
Capybara.default_selector = :xpath
Capybara.default_wait_time = 10
Capybara.app_host = 'http://localhost:4567' # change url

require 'selenium-webdriver'

Capybara.default_driver = :selenium
Capybara.javascript_driver = :selenium
