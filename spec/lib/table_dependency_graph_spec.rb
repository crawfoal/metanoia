require 'rails_helper'
require "#{Rails.root}/lib/table_dependency_graph"

RSpec.describe TableDependencyGraph do
  describe '#tsort' do
    it 'returns a topological sort of the tables, where the dependency is the '\
       'fk constraint' do
      tdg = TableDependencyGraph.new(:grade_systems, :grades, :buckets)

      sorted_table_names = tdg.tsort

      expect(sorted_table_names.last).to eq 'grades'
      expect(sorted_table_names.length).to eq 3
    end

    it 'works properly when there is a polymorphic association' do
      tdg = TableDependencyGraph.new(:employments, :setter_stories)

      expect(tdg.tsort).to eq %w(setter_stories employments)
    end
  end
end
