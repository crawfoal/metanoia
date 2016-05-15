module SeedData
  SEEDED_TABLES = %w(grade_systems grades)

  class << self
    def clear_all_seeded_tables
      SEEDED_TABLES.each do |table_name|
        table_name.classify.constantize.destroy_all
      end
    end
  end
end

Dir[File.dirname(__FILE__) + '/**/*.rb'].each { |file| require file }
