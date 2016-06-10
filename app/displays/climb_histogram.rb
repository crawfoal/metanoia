class ClimbHistogram
  def initialize(climbs, grade_system)
    @climbs = climbs
    @grade_system = grade_system
  end

  def data
    grade_ids_and_names.map do |grade_id_and_name|
      grade_id, *name = grade_id_and_name
      name.push(counts_by_grade_id[grade_id] || 0)
    end
  end

  def has_data?
    @climbs.exists?
  end

  private

  def counts_by_grade_id
    @_cbg ||= @climbs.joins(:grade).group(:grade_id).count
  end

  def grade_ids_and_names
    @_gin ||= Grade.where(grade_system_id: @grade_system.id).ordered.pluck(:id, :name) + Grade.null_object.pluck(:id, :name)
  end
end
