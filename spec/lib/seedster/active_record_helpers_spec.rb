require 'rails_helper'

RSpec.describe Seedster::ActiveRecordHelpers do
  m = Module.new
  
  class m::Post < ActiveRecord::Base
    include Seedster::ActiveRecordHelpers

    has_no_table database: :pretend_success

    only_allow_seeded_records
  end

  describe '.only_allow_seeded_records' do
    it 'creates a callback that prevents record saving when Seedster is not '\
       'running a migration' do
      allow(Seedster).to receive(:migrating?).and_return(false)

      expect { m::Post.create! }.to raise_error ActiveRecord::RecordNotSaved
    end

    it 'creates a callback that allows record saving when Seedster is running'\
       'a migration' do
      allow(Seedster).to receive(:migrating?).and_return(true)

      expect { m::Post.create! }.to_not raise_error
    end
  end
end
