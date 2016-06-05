class AddYosemiteDecimalScale
  def up
    yds = GradeSystem.create!(name: 'Yosemite')
    grade_names = (5..9).map { |num| "5.#{num}" } +
                  ((10..15).map do |num|
                    ('a'..'d').map { |letter| "5.#{num}#{letter}" }
                  end).flatten[0..-2]
    grade_names.each_with_index do |grade_name, index|
      Grade.create!(
        name: grade_name,
        grade_system: yds,
        sequence_number: index,
      )
    end
  end

  def down
    GradeSystem.find_by_name('Yosemite').destroy
    # associated grades are destroyed due to `dependent: :destroy`
  end
end
