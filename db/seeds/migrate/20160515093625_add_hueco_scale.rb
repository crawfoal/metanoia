class AddHuecoScale
  def up
    hueco_scale = GradeSystem.create!(name: 'Hueco')
    grade_names = (['B'] + (0..16).to_a).map { |num| "V#{num}" }
    grade_names.each_with_index do |grade_name, index|
      Grade.create!(
        name: grade_name,
        grade_system: hueco_scale,
        sequence_number: index,
      )
    end
  end

  def down
    GradeSystem.find_by_name('Hueco').destroy
    # associated grades are destroyed due to `dependent: :destroy`
  end
end
