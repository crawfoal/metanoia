# More info at https://github.com/guard/guard#readme

guard :rspec, cmd: "bundle exec rspec" do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  # Rails files
  rails = dsl.rails(view_extensions: %w(erb haml slim))
  dsl.watch_spec_files_for(rails.app_files)
  dsl.watch_spec_files_for(rails.views)

  watch(rails.controllers) do |m|
    [
      rspec.spec.("routing/#{m[1]}_routing"),
      rspec.spec.("controllers/#{m[1]}_controller")
    ]
  end

  # Rails config changes
  watch(rails.spec_helper)     { rspec.spec_dir }
  watch(rails.routes)          { "#{rspec.spec_dir}/controllers" }
  watch(rails.app_controller)  { "#{rspec.spec_dir}/controllers" }

  # Capybara features specs
  watch(rails.view_dirs)     { |m| rspec.spec.("features/#{m[1]}") }
  watch(rails.layouts)       { |m| rspec.spec.("features/#{m[1]}") }
  watch("app/views/layouts/application.html.haml") { "#{rspec.spec_dir}/features" }
  watch("#{rspec.spec_dir}/feature_helper.rb") { "#{rspec.spec_dir}/features" }
  watch("#{rspec.spec_dir}/features/support/page_objects/base.rb") { "#{rspec.spec_dir}/features" }

  # View Helpers
  watch("app/views/layouts/_flash.html.haml") { "#{rspec.spec_dir}/helpers/flash_helper_spec.rb" }

  # ----------------------------------------------------------------------------
  # App Specific Patterns
  # ----------------------------------------------------------------------------

  # Gyms
  watch("app/models/forms/gym.rb") { "#{rspec.spec_dir}/features/gyms_spec.rb" }
  watch("app/controllers/gyms_controller.rb") { "#{rspec.spec_dir}/features/gyms_spec.rb" }
  watch("app/controllers/sections_controller.rb") { "#{rspec.spec_dir}/features/gyms_spec.rb" }
  watch("app/views/gyms/_section_fields.html.haml") { "#{rspec.spec_dir}/features/gyms_spec.rb" }
  watch("app/views/sections/_new_section_fields.html.haml") { "#{rspec.spec_dir}/features/gyms_spec.rb" }
  watch("app/views/sections/new.js.coffee") { "#{rspec.spec_dir}/features/gyms_spec.rb" }
  watch("#{rspec.spec_dir}/features/support/page_objects/gyms/form.rb") { "#{rspec.spec_dir}/features/gyms_spec.rb" }
  watch("#{rspec.spec_dir}/features/support/page_objects/gyms/index.rb") { "#{rspec.spec_dir}/features/gyms_spec.rb" }
end
