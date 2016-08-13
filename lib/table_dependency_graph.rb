require 'tsort'

# Does not yet support non default table or association names (i.e. those that
# don't come from the class name).
class TableDependencyGraph
  include TSort

  def initialize(*table_names)
    @table_names = table_names.map(&:to_s)
  end

  # This method is called by TSort to iterate over each node in the graph
  def tsort_each_node(&block)
    @table_names.each(&block)
  end

  # This method is called by TSort for each child, and should iterate over each
  # of the child's parent nodes.
  def tsort_each_child(table_name, &block)
    TableInspector.new(table_name).
      select_parents_from(@table_names).each(&block)
  end

  class TableInspector
    def initialize(table_name)
      @model_klass = table_name.classify.constantize
    end

    def select_parents_from(table_names)
      table_names.select do |table_name|
        TableInspector.new(table_name).parent_to? self
      end
    end

    def parent_to?(other_table)
      other_table.child_associations.any? do |association|
        if association.polymorphic?
          polymorphic_parent_as? association.name
        else
          association.name == singular_association_name
        end
      end
    end

    def child_associations
      @model_klass.reflect_on_all_associations(:belongs_to)
    end

    def parent_associations
      @model_klass.reflect_on_all_associations.select do |association|
        [:has_one, :has_many].include? association.macro
      end
    end

    def polymorphic_parent_as?(association_name)
      parent_associations.any? do |association|
        association.options[:as] == association_name
      end
    end

    def singular_association_name
      @model_klass.model_name.singular.to_sym
    end
  end
end
