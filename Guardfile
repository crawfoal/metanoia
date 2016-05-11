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
  watch("app/views/layouts/_flash.html.haml") do
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

  watch("app/views/layouts/_navbar.html.haml") do
    "#{rspec.spec_dir}/features/home_spec.rb"
  end
end
