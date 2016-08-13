require 'tsort'

class TableDependencyGraph
  include TSort

  def initialize(*table_names)
    @table_names = table_names.map(&:to_s)
  end

  def tsort_each_node(&block)
    @table_names.each(&block)
  end

  def tsort_each_child(table_name, &block)
    model_class = table_name.classify.constantize
    parent_associations = model_class.reflect_on_all_associations(:belongs_to)
    table_names_for(parent_associations).each(&block)
  end

  private

  def table_names_for(associations)
    associations.map do |association|
      if association.polymorphic?
        polymorphic_associtated_klasses(association)
      else
        association.klass
      end
    end.flatten.map(&:table_name).select { |table_name| @table_names.include? table_name }
  end

  # https://www.viget.com/articles/identifying-foreign-key-dependencies-from-activerecordbase-classes
  def polymorphic_associtated_klasses(association)
    ActiveRecord::Base.descendants.select do |model|
      model.reflect_on_all_associations.any? do |parent_association|
        next if parent_association.belongs_to? # not really a parent
        parent_association.options[:as] == association.name
      end
    end
  end
end
