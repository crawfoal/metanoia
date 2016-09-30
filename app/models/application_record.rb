class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Assumes that the subquery produces a table that contains a column with a
  # foreign key pointing to the receiver class's table, and that this column is
  # named in the conventional way (class name with _id appended). If you have a
  # `query` that produces a table of climbs, including their `grade_id` foreign
  # key column, then this:
  #   Grades.left_join_subquery(query, :climbs)
  # is equivalent to this:
  #   Grades.joins(<<-SQL).
  #     LEFT JOIN (#{query.to_sql}) climbs
  #     ON grades.id = climbs.grade_id
  #   SQL
  def self.left_join_subquery(subquery, table_alias)
    joins(<<-SQL)
      LEFT JOIN (#{subquery.to_sql}) #{table_alias}
      ON #{table_name}.id = #{table_alias}.#{table_name.singularize}_id
    SQL
  end
end
