class AddRainbowScale
  def up
    rainbow_scale = GradeSystem.create!(name: 'Rainbow Scale')
    grade_names = %w(purple blue green yellow orange red black)
    grade_names.each_with_index do |grade_name, index|
      Grade.create!(
        name: grade_name,
        grade_system: rainbow_scale,
        sequence_number: index
      )
    end
  end

  def down
    GradeSystem.find_by_name('Rainbow Scale').destroy
    # associated grades are destroyed due to `dependent: :destroy`
  end
end
