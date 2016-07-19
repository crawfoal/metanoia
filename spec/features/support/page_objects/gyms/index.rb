module PageObjects
  module Gyms
    class Index < Base
      # ----- Action Methods -----

      # ----- Expectation Methods -----
      def has_gym?(name)
        gyms_table.has_content? name
      end

      def has_employee_list_link_for?(gym)
        row_for(gym).has_link? 'Employee List'
      end

      private

      # ----- Finder Methods -----
      def gyms_table
        find 'table#gyms'
      end
      alias_method :main_element, :gyms_table

      def row_for(gym)
        find '#gyms tr', text: /.*#{gym.name}.*/
      end
    end
  end
end
