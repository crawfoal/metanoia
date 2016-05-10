module Metanoia
  SEEDED_MODELS = [GradeSystem, Grade]
  SEEDED_TABLES = SEEDED_MODELS.map do |model_class|
    model_class.to_s.underscore.pluralize
  end
end

Metanoia::SEEDED_MODELS.each do |model|
  SeedMigration.register model
end
