require 'rails_helper'
require "#{Rails.root}/lib/table_dependency_graph"

RSpec.describe TableDependencyGraph do
  describe '#tsort' do
    it 'returns a topological sort of the tables, where the dependency is the '\
       'fk constraint' do
      tdg = TableDependencyGraph.new(:grade_systems, :grades, :buckets)
      expect(tdg.tsort.last).to eq 'grades'
    end
  end
end
