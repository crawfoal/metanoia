module SeedData::GradeSystems
  class << self
    def create_hueco
      hueco_system = GradeSystem.create(name: 'Hueco Scale')
      grade_names = ['VB'] + (0..16).map { |num| "V#{num}" }
      grade_names.each_with_index do |grade_name, index|
        Grade.create name: grade_name, order: index, grade_system: hueco_system
      end
    end
  end
end
