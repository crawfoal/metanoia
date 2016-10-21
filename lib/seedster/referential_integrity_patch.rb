require 'active_record/connection_adapters/postgresql_adapter'

# delete once Rails PR #21233 is merged in and we've upgraded
module Seedster
  module ReferentialIntegrityPatch
    def wrap_with_transaction_that_disables_ri
      disable_all_user_triggers
      tables_constraints = find_non_deferrable_fk_constraints
      print "INFO: #{tables_constraints.size} non-deferrable fk constraints "\
           "were found... "
      alter_to_be_deferrable(tables_constraints)
      puts 'we were able to temporarily make '\
           "#{tables_constraints.size - find_non_deferrable_fk_constraints.size}"\
           ' of them deferrable'
      transaction do
        execute("SET CONSTRAINTS ALL DEFERRED")
        puts 'INFO: "SET CONSTRAINTS ALL DEFERRED" has executed'
        yield
      end
      alter_to_be_non_deferrable(tables_constraints)
      puts 'INFO: attempted to switch modified fk constraints back to their '\
           'original, non-deferrable status... there are now '\
           "#{find_non_deferrable_fk_constraints.size} non-deferrable "\
           'fk constraints'
      enable_all_user_triggers
    end

    def disable_all_user_triggers
      statements = ActiveRecord::Base.connection.tables.collect do |name|
        "ALTER TABLE #{quote_table_name(name)} DISABLE TRIGGER USER"
      end
      execute(statements.join(";"))
    end

    def enable_all_user_triggers
      statements = ActiveRecord::Base.connection.tables.collect do |name|
        "ALTER TABLE #{quote_table_name(name)} ENABLE TRIGGER USER"
      end
      execute(statements.join(";"))
    end

    def self.monkey_patches?(klass)
      instance_methods(false).any? do |method_name|
        klass.respond_to? method_name
      end
    end

    def find_non_deferrable_fk_constraints
      execute(<<-SQL).values
        SELECT table_name, constraint_name
        FROM information_schema.table_constraints
        WHERE constraint_type = 'FOREIGN KEY' AND is_deferrable = 'NO'
      SQL
    end

    def alter_to_be_deferrable(tables_constraints)
      statements = tables_constraints.collect do |table, constraint|
        "ALTER TABLE #{quote_table_name(table)} "\
        "ALTER CONSTRAINT #{constraint} DEFERRABLE"
      end
      execute(statements.join(';'))
    end

    def alter_to_be_non_deferrable(tables_constraints)
      statements = tables_constraints.collect do |table, constraint|
        "ALTER TABLE #{quote_table_name(table)} "\
        "ALTER CONSTRAINT #{constraint} NOT DEFERRABLE"
      end
      execute(statements.join(';'))
    end
  end
end

if Seedster::ReferentialIntegrityPatch.monkey_patches? \
     ActiveRecord::ConnectionAdapters::PostgreSQLAdapter
  raise 'Whoops, `ActiveRecord::ConnectionAdapters::PostgreSQLAdapter` '\
        'now implments one of the methods in '\
        "`Seedster::ReferentialIntegrityPatch`, so we can't include that "\
        'module in the class'
else
  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.include \
    Seedster::ReferentialIntegrityPatch
end
