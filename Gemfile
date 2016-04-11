source 'https://rubygems.org'
ruby '2.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Use puma so we can process concurrent requests
gem 'puma'
# Time out long running request
gem 'rack-timeout'

# Print things in a neat format with `ap`
gem 'awesome_print'
# Use pry in console instead of irb
gem 'pry'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Use haml instead of erb (for regular html views)
gem 'haml'
gem 'haml-rails'
# Use Font Awesome for icons
gem 'font-awesome-sass'

# Use virtus to define attributes for form objects
gem 'virtus'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Use guard to automatically run specs as files are saved
  gem 'guard-rspec', require: false

  # Use Factory Girl to create test data
  gem 'factory_girl_rails'
  # Use RSpec for testing
  gem 'rspec-rails'
  # Use Capybara to interract with the browser during specs.
  gem 'capybara'
  # Use Database cleaner to clean up between tests
  gem 'database_cleaner'
  # Use Selenium-Webdriver to run feature specs that require JavaScript
  gem 'selenium-webdriver'
  # Install this helper gem so we can easily have Selenium use Chrome instead of Firefox
  gem 'chromedriver-helper'
end

group :test do
  # Provides convenient one-liners that test common Rails functionality
  gem 'shoulda-matchers'

  # Use webmock to enforce whitelisting of hosts that can be sent requests during testing
  gem 'webmock'

  # Report data from test suite to Code Climate
  gem 'codeclimate-test-reporter', require: nil

  # Report data from test suite to Codacy
  gem 'codacy-coverage', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  # For Heroku; enables features like static asset serving and logging
  gem 'rails_12factor'
end
