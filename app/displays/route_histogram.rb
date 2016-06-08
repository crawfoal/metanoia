class RouteHistogram
  def initialize(routes)
    @routes = routes
  end

  def data
    # Ideally, I'd like to implement this using one query, something like
    #   .joins(:climbs).select('grades.name, COUNT(*)').where(
    #     climbs: {type: 'Route'}).group('climbs.grade_id')
    # but Postgres doesn't allow this - requires that all selected columns are
    # in the GROUP BY clause... I think because multiple values could be
    # possible if the columns aren't in the GROUP BY clause?
    
    counts_by_grade_id = @routes.joins(:grade).group(:grade_id).count
    grade_ids_and_names =
      Grade.ordered.where(id: counts_by_grade_id.keys).pluck(:id, :name)

    grade_ids_and_names.map do |grade_id_and_name|
      grade_id, *name = grade_id_and_name

      name.push(counts_by_grade_id[grade_id])
    end
  end
end
