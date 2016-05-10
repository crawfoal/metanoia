class AddGradeSystems < SeedMigration::Migration
  def up
    create_hueco
    create_yds
  end

  def down
    GradeSystem.find_by_name('Hueco Scale').destroy
    GradeSystem.find_by_name('YDS').destroy
  end

  def create_hueco
    hueco_system = GradeSystem.create(name: 'Hueco Scale')
    grade_names = ['VB'] + (0..16).map { |num| "V#{num}" }
    grade_names.each_with_index do |grade_name, index|
      Grade.create name: grade_name, order: index, grade_system: hueco_system
    end
  end

  def create_yds
    yds = GradeSystem.create(name: 'YDS')

    grade_names = (5..9).map { |num| "5.#{num}" }
    grade_names += ((10..15).map do |num|
                      ('a'..'d').map { |letter| "5.#{num}#{letter}" }
                    end)
    grade_names = grade_names.flatten[0..-2]

    grade_names.each_with_index do |grade_name, index|
      Grade.create name: grade_name, order: index, grade_system: yds
    end
  end
end
