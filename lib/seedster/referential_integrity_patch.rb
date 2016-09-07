require 'active_record/connection_adapters/postgresql_adapter'

# delete once Rails PR #21233 is merged in and we've upgraded
module Seedster
  module ReferentialIntegrityPatch
    def wrap_with_transaction_that_disables_ri
      disable_all_user_triggers
      transaction do
        execute("SET CONSTRAINTS ALL DEFERRED")
        yield
      end
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
