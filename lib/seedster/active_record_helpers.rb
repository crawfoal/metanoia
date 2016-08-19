require 'active_support/concern'

module Seedster
  module ActiveRecordHelpers
    extend ActiveSupport::Concern

    module ClassMethods
      def only_allow_seeded_records
        before_save do
          Seedster.migrating?
          # for Rails 5.0
          # throw(:abort) unless Seedster.migrating?
        end
      end
    end
  end
end
