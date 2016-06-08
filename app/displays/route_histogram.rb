class RouteHistogram
  def initialize(routes)
    @routes = routes
  end

  def data
    grade_ids_and_names.map do |grade_id_and_name|
      grade_id, *name = grade_id_and_name
      name.push(counts_by_grade_id[grade_id])
    end
  end

  def has_data?
    @routes.exists?
  end

  private

  def counts_by_grade_id
    @_cbg ||= @routes.joins(:grade).group(:grade_id).count
  end

  def grade_ids_and_names
    @_gin ||= Grade.ordered.where(id: counts_by_grade_id.keys).pluck(:id, :name)
  end
end
