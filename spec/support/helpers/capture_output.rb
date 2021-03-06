module CaptureOutput
  def capture_stdeo
    original_stderr, original_stdout = $stderr.dup, $stdout.dup
    log_file = File.new("#{Rails.root}/spec/console.log", 'w')
    $stderr = log_file
    $stdout = log_file
    yield
  ensure
    $stderr, $stdout = original_stderr, original_stdout
  end
end

RSpec.configure do |config|
  config.include CaptureOutput
end
