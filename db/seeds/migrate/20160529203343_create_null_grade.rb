class CreateNullGrade
  def up
    null_grade_system = GradeSystem.create!(
      name: 'Null Grade System'
    )
    null_grade = Grade.create!(
      name: '?',
      grade_system: null_grade_system,
      sequence_number: -1
    )
  end

  def down
    GradeSystem.find_by_name('Null Grade System').destroy
    # associated grades are destroyed due to `dependent: :destroy`
  end
end
