require 'turnip'
require 'turnip/capybara'
require 'turnip/rspec'
require 'capybara'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, { js_error: false,
    default_wait_time: 30, timeout: 100 } )
end

Capybara.register_driver :pc do |app|
  Capybara::RackTest::Driver.new(app,
    headers:  { 'HTTP_USER_AGENT' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X)' } )
end

Capybara.configure do |config|
  config.default_driver = :pc
  config.javascript_driver = :poltergeist
  config.ignore_hidden_elements = true
  config.default_wait_time = 30
end

Dir.glob('spec/steps/*.steps.rb') { |f| load f, true }
