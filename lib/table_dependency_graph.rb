require 'tsort'

class TableDependencyGraph
  include TSort

  def initialize(*table_names)
    @table_names = table_names.map(&:to_s)
  end

  def tsort_each_node(&block)
    @table_names.each(&block)
  end

  # doesn't handle polymorphic associations yet
  def tsort_each_child(table_name, &block)
    model_class = table_name.classify.constantize
    parent_associations = model_class.reflect_on_all_associations(:belongs_to)
    parent_associations.map(&:klass).map(&:table_name).each(&block)
  end
end
