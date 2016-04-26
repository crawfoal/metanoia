require 'spec_helper'
require_relative '../../lib/tasks/communicator'

RSpec.describe Tasks::Communicator do
  it 'delegates print to STDOUT' do
    expect(STDOUT).to receive(:print)
    Tasks::Communicator.print('Foo')
  end

  it 'delegates `puts` to `STDOUT`' do
    expect(STDOUT).to receive(:puts)
    Tasks::Communicator.puts('Bar')
  end

  it 'delegates `gets` to `STDIN`' do
    expect(STDIN).to receive(:gets)
    Tasks::Communicator.gets
  end
end
