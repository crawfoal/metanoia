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
gem 'font-awesome-rails'
# Bourbon is a Sass mixin library
gem 'bourbon'
# Neat is a grid framework built with Bourbon
gem 'neat'
# Use chartkick to interface with GoogleCharts so that we can make HTML5/SVG
# graphs to visualize data (e.g. how many climbs of each grade does this gym
# have?)
gem "chartkick"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use Devise for authentication
gem 'devise'
# Use Rolify to define roles, e.g. "admin", "setter", "athlete", etc.
gem 'rolify'
# Use Pundit to enforce authorization
gem 'pundit'

# Use Faker when generating sample data and temporary passwords
gem 'faker'
# Use Factory Girl to create test data (and sample data)
gem 'factory_girl_rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Use guard to automatically run specs as files are saved
  gem 'guard-rspec', require: false

  # Use Bullet to detect N+1 query problems
  gem 'bullet'

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
  # Provide matchers for testing Pundit policy classes
  gem 'pundit-matchers'

  # Use webmock to enforce whitelisting of hosts that can be sent requests during testing
  gem 'webmock'

  # Report data from test suite to Code Climate
  gem 'codeclimate-test-reporter', require: nil

  # Use SimpleCov for test coverage reporting on local machines
  gem 'simplecov', require: false

  # Use launchy to automatically open page snapshots taken during feaure specs
  gem 'launchy'

  # Use ammeter to provide helpers for testing generators
  gem 'ammeter'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Use rails-erd to make entity-relationship diagrams of our models
  gem 'rails-erd'
end

group :production do
  # For Heroku; enables features like static asset serving and logging
  gem 'rails_12factor'
end
