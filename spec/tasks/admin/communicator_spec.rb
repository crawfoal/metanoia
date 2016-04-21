require 'spec_helper'
require_relative '../../../lib/tasks/admin/communicator'

RSpec.describe Tasks::Admin::Communicator do
  it 'delegates print to STDOUT' do
    expect(STDOUT).to receive(:print)
    Tasks::Admin::Communicator.print('Foo')
  end

  it 'delegates `puts` to `STDOUT`' do
    expect(STDOUT).to receive(:puts)
    Tasks::Admin::Communicator.puts('Bar')
  end

  it 'delegates `gets` to `STDIN`' do
    expect(STDIN).to receive(:gets)
    Tasks::Admin::Communicator.gets
  end
end
