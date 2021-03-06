# More info at https://github.com/guard/guard#readme
require 'active_support/inflector'

guard :rspec, cmd: "NO_COVERAGE=true bundle exec rspec" do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)
  watch(%r(^spec/features/support/.*\.rb$)) do
    "#{rspec.spec_dir}/features"
  end

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  # Rails files
  view_extensions = %w(haml coffee)
  rails = dsl.rails(view_extensions: view_extensions)
  dsl.watch_spec_files_for(rails.app_files)
  dsl.watch_spec_files_for(rails.views)

  watch(rails.controllers) do |m|
    [
      rspec.spec.("controllers/#{m[1]}_controller"),
      rspec.spec.("features/#{m[1]}")
    ]
  end

  # Rails config changes
  watch(rails.spec_helper)     { rspec.spec_dir }
  watch(rails.routes) do
    [
      "#{rspec.spec_dir}/controllers",
      "#{rspec.spec_dir}/features"
    ]
  end
  watch(rails.app_controller) do
  [
    "#{rspec.spec_dir}/controllers",
    "#{rspec.spec_dir}/features"
  ]
  end

  # Capybara features specs
  watch(rails.view_dirs)     { |m| rspec.spec.("features/#{m[1]}") }
  watch(rails.layouts)       { |m| rspec.spec.("features/#{m[1]}") }
  watch(%r(^spec/features/support/page_objects/(.+)/.+\.rb$)) do |m|
    rspec.spec.("features/#{m[1]}")
  end
  files_to_trigger_all_feature_specs = [
    "app/views/layouts/application.html.haml",
    "#{rspec.spec_dir}/feature_helper.rb",
    "#{rspec.spec_dir}/features/support/page_objects/base.rb"
  ]
  files_to_trigger_all_feature_specs.each do |thing_to_watch|
    watch(thing_to_watch) do
      "#{rspec.spec_dir}/features"
    end
  end

  # Form Objects
  watch(%r(^app/forms/(.+)_form\.rb$)) do |m|
    plural_model_name = ActiveSupport::Inflector.pluralize(m[1])
    [
      rspec.spec.("features/#{plural_model_name}"),
      rspec.spec.("controllers/#{plural_model_name}_controller")
    ]
  end

  # Policies
  watch("app/policies/application_policy.rb") { "#{rspec.spec_dir}/policies" }

  # View Helpers
  watch("app/views/shared/_flash.html.haml") do
    "#{rspec.spec_dir}/helpers/flash_helper_spec.rb"
  end

  # Factories
  watch(%r(^spec/factories/.+\.rb$)) { rspec.spec_dir }

  # Rake Tasks
  watch(%r(^lib/tasks/(.+)\.rake$)) { |m| rspec.spec.("tasks/#{m[1]}") }
  watch(%r(^lib/tasks/(.+)/.+\.rb$)) { |m| "spec/tasks/#{m[1]}" }

  # Generators
  watch(%r(^lib/generators/([^/]+)/.+)) do |m|
    rspec.spec.("generators/#{m[1]}_generator")
  end

  # Non-shared support files (assumes they are grouped in a folder within the
  # folder that has the specs)
  watch(%r(^spec/((?!support).+)/.+/.+(?<!spec)\.rb$)) { |m| "spec/#{m[1]}" }

  # Javascript Files
  watch(%r(^app/assets/javascripts/[^/]+\.(coffee|js)$)) do
    "#{rspec.spec_dir}/features"
  end
  watch("app/assets/javascripts/pages/sections/show.coffee") do
    rspec.spec.('features/setters/reset')
  end

  # ----------------------------------------------------------------------------
  # App Specific Patterns
  # ----------------------------------------------------------------------------

  # Files related to Section model should trigger Climb and Gym feature specs
  section_files_to_watch = [
    "app/controllers/sections_controller.rb",
    %r(^app/views/sections/.+\.(?:#{view_extensions * '|'})$)
  ]
  section_files_to_watch.each do |thing_to_watch|
    watch(thing_to_watch) do
      [
        rspec.spec.('features/gyms'),
        rspec.spec.('features/climbs')
      ]
    end
  end

  section_reset_files = [
    'app/views/sections/_show.html.haml',
    'app/controllers/climbs_controller.rb',
    'app/views/climbs/update.js.coffee'
  ]
  section_reset_files.each do
    rspec.spec.('features/setters/reset')
  end

  watch("app/views/layouts/_navbar.html.haml") do
    "#{rspec.spec_dir}/features/home_spec.rb"
  end

  watch("app/models/bucket.rb") do
    [
      "#{rspec.spec_dir}/db/seeds/generators/bucket_generator_spec.rb",
      "#{rspec.spec_dir}/db/seeds/data/buckets_spec.rb"
    ]
  end

  watch(%r(^lib/seedster/.+\.rb$)) { rspec.spec.('lib/seedster') }

  [
    'app/controllers/employments_controller.rb',
    'app/views/employments/index.html.haml',
    'app/views/employments/_table_row.html.haml',
    'app/forms/employment_form.rb',
    'app/controllers/employments_controller.rb',
    'app/views/employments/create.js.coffee',
    'app/views/employments/_form.html.haml',
    'app/views/employments/new.js.coffee'
  ].each do |filename|
    watch(filename) do
      rspec.spec.('features/employee_list')
    end
  end

  watch('app/forms/employment_form.rb') do
    rspec.spec.('features/employee_list')
  end
end
