module PageObjects
  module Climbs
    class Form < Base
      # ----- Action Methods -----
      def choose_route
        form_element.find('input#climb_type_route + span').click
      end

      def choose_boulder
        form_element.find('input#climb_type_boulder + span').click
      end

      def select(item)
        form_element.select item
      end
      alias_method :grade=, :select
      alias_method :color=, :select

      def fill_with(attributes = {})
        choose_route if attributes[:type] == 'Route'
        choose_boulder if attributes[:type] == 'Boulder'
        grade = attributes[:grade] if attributes[:grade].present?
        grade = attributes[:color] if attributes[:color].present?
      end

      def submit
        form_element.click_on 'Save'
      end

      # ----- Expectation Methods -----
      def for_section?(section_name)
        section_id_field = form_element.first(
          '#climb_section_id',
          visible: false
        )
        section_id = section_id_field.value
        if section_id.present?
          Section.find(section_id).name == section_name
        else
          false
        end
      end

      private

      # ----- Finder Methods -----
      def form_element
        find 'form[class="new_climb"]'
      end
      alias_method :main_element, :form_element
    end
  end
end
