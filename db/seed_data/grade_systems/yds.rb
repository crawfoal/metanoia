module SeedData::GradeSystems
  class << self
    def create_yds
      yds = GradeSystem.create(name: 'YDS')

      # Initialize with lower grades, without letters.
      grade_names = (5..9).map { |num| "5.#{num}" }

      # Add in higher grades, with letters.
      grade_names += ((10..15).map do |num|
                        ('a'..'d').map { |letter| "5.#{num}#{letter}" }
                      end)

      # Remove last element (5.15d), and flatten nested arrays out to one big
      # array.
      grade_names = grade_names.flatten[0..-2]

      grade_names.each_with_index do |grade_name, index|
        Grade.create name: grade_name, order: index, grade_system: yds
      end
    end
  end
end
