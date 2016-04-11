module PageObjects
  module Gyms
    class Index < Base
      # ----- Action Methods -----

      # ----- Expectation Methods -----
      def has_gym?(name)
        gyms_table.has_content? name
      end

      private

      # ----- Finder Methods -----
      def gyms_table
        find 'table#gyms'
      end
      alias_method :main_element, :gyms_table
    end
  end
end
