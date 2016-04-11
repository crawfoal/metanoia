module PageObjects
  module Gyms
    class Form < Base

      def initialize
        @num_sections_with_a_name = sections_fieldset.all("input[placeholder='name'][value]").size
      end

      # ----- Action Methods -----
      def add_fields_for_another_gym
        click_on 'add_new_section'
      end

      def set_gym_name_to(name)
        form_element.fill_in 'gym_name', with: name
      end

      def set_next_section_name_to(name)
        sections_fieldset.fill_in "gym_sections_attributes_#{@num_sections_with_a_name}_name", with: name
        @num_sections_with_a_name += 1
      end
      alias_method :set_first_section_name_to, :set_next_section_name_to

      def submit
        click_on 'Save'
      end

      # ----- Expectation Methods -----
      def has_fields_for_this_many_sections?(num)
        sections_fieldset.assert_selector('.section-fields', count: num)
      end

      def has_fields_for_one_section?
        has_fields_for_this_many_sections? 1
      end

      HAS_FIELDS_FOR_SECTIONS_REGEX = /\Ahas_fields_for_(\d+)_sections\?\Z/
      def method_missing(method_sym, *args, &block)
        if method_sym.to_s =~ HAS_FIELDS_FOR_SECTIONS_REGEX
          has_fields_for_this_many_sections? $1
        else
          super
        end
      end
      def respond_to_missing?(method_sym, include_private = false)
        method_sym.to_s =~ HAS_FIELDS_FOR_SECTIONS_REGEX || super
      end

      private

      # ----- Finder Methods -----
      def form_element
        find 'form#new_gym'
      end
      alias_method :main_element, :form_element

      def sections_fieldset
        form_element.find 'fieldset#gym_sections'
      end
    end
  end
end
