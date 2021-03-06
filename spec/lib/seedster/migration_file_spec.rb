require 'rails_helper'
require "#{Rails.root}/lib/seedster"

RSpec.describe Seedster::MigrationFile do
  describe '#version' do
    it "returns the migration's version as specified in the filename" do
      migration = Seedster::MigrationFile.new(
        "#{Rails.root}/spec/lib/seedster/sample_migrations/"\
        "20160511115239_create_sam.rb"
      )

      expect(migration.version).to eq '20160511115239'
    end
  end

  describe '#instantiate_migration' do
    it 'returns an instance of the class specified in the migration' do
      migration = Seedster::MigrationFile.new(
        "#{Rails.root}/spec/lib/seedster/sample_migrations/"\
        "20160511115239_create_sam.rb"
      )

      expect(migration.instantiate_migration).to be_a CreateSam
    end
  end
end
