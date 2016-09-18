source 'https://rubygems.org'
ruby '2.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Use puma so we can process concurrent requests
gem 'puma', '~> 3.4.0'
# Time out long running request
gem 'rack-timeout', '~> 0.4.2'

# Print things in a neat format with `ap`
gem 'awesome_print', '~> 1.7.0'
# Use pry in console instead of irb
gem 'pry', '~> 0.10.3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 3.0.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2.1'
# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.2.1'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~> 2.5.3'
# Use haml instead of erb (for regular html views)
gem 'haml', '~> 4.0.7'
gem 'haml-rails', '~> 0.9.0'
# Use Font Awesome for icons
gem 'font-awesome-rails', '~> 4.6.3.1'
# Bourbon is a Sass mixin library
gem 'bourbon', '~> 4.2.6'
# Neat is a grid framework built with Bourbon
gem 'neat', '~> 1.8.0'
# Use chartkick to interface with GoogleCharts so that we can make HTML5/SVG
# graphs to visualize data (e.g. how many climbs of each grade does this gym
# have?)
gem 'chartkick', '~> 2.1.1'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use Devise for authentication
gem 'devise', '~> 4.0.0'
# Use Rolify to define roles, e.g. "admin", "setter", "athlete", etc.
gem 'rolify', '~> 5.1.0'
# Use Pundit to enforce authorization
gem 'pundit', '~> 1.1.0'

# Use Faker when generating sample data and temporary passwords
gem 'faker', '~> 1.6.3'
# Use Factory Girl to create test data (and sample data)
gem 'factory_girl_rails', '~> 4.7.0'

# Use table_print to easily print data in the Rails console, formated like a
# table
gem 'table_print', '~> 1.5.6'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 9.0.5'
  # Use guard to automatically run specs as files are saved
  gem 'guard-rspec', '~> 4.6.5', require: false

  # Use Bullet to detect N+1 query problems
  gem 'bullet', '~> 5.0.0'

  # Use RSpec for testing
  gem 'rspec-rails', '~> 3.4.2'
  # Use Capybara to interract with the browser during specs.
  gem 'capybara', '~> 2.7.0'
  # Use Database cleaner to clean up between tests
  gem 'database_cleaner', '~> 1.5.1'
  # Use Selenium-Webdriver to run feature specs that require JavaScript
  gem 'selenium-webdriver', '~> 2.53.0'
  # Install this helper gem so we can easily have Selenium use Chrome instead of Firefox
  gem 'chromedriver-helper', '~> 1.0.0'
end

group :test do
  # Provides convenient one-liners that test common Rails functionality
  gem 'shoulda-matchers', '~> 3.1.1'
  # Provide matchers for testing Pundit policy classes
  gem 'pundit-matchers', '~> 1.1.0'

  # Use webmock to enforce whitelisting of hosts that can be sent requests during testing
  gem 'webmock', '~> 2.1.0'

  # Report data from test suite to Code Climate
  gem 'codeclimate-test-reporter', '~> 0.6.0', require: nil

  # Use SimpleCov for test coverage reporting on local machines
  gem 'simplecov', '~> 0.12.0', require: false

  # Use launchy to automatically open page snapshots taken during feaure specs
  gem 'launchy', '~> 2.4.3'

  # Use ammeter to provide helpers for testing generators
  gem 'ammeter', '~> 1.1.3'

  # Allows us to create pretend models in the specs
  gem 'activerecord-tableless', '~> 1.3.4'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.3.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.6.4'

  # Use rails-erd to make entity-relationship diagrams of our models
  gem 'rails-erd', '~> 1.5.0'
end

group :production do
  # For Heroku; enables features like static asset serving and logging
  gem 'rails_12factor', '~> 0.0.3'
end
