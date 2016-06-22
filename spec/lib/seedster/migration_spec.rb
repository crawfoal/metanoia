require 'rails_helper'
require "#{Rails.root}/lib/seedster"

RSpec.describe Seedster::Migration do
  let(:migration) do
    Seedster::Migration.new(
      "#{Rails.root}/spec/tasks/seed/sample_migrations/"\
      "20160511115239_create_sam.rb"
    )
  end

  describe '#version' do
    it "returns the migration's version as specified in the filename" do
      expect(migration.version).to eq '20160511115239'
    end
  end

  describe '#instantiate' do
    it 'returns an instance of the class specified in the migration' do
      expect(migration.instantiate).to be_a CreateSam
    end
  end
end
