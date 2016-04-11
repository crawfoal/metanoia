require "codeclimate-test-reporter"
require 'codacy-coverage'

if ENV['CODACY_RUN_LOCAL']
  Codacy::Reporter.start
else
  CodeClimate::TestReporter.start
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.example_status_persistence_file_path = "spec/examples.txt"

  config.disable_monkey_patching!

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.order = :random

  Kernel.srand config.seed
end

require 'webmock/rspec'
WebMock.disable_net_connect!(
  allow_localhost: true,
  allow: ['codeclimate.com', 'api.codacy.com']
)
