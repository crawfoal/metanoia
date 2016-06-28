require 'rails_helper'

class SomeForm < BaseForm
  delegate_basic_form_interface_methods to: :@object
end

RSpec.describe BaseForm do
  describe '.delegate_basic_form_interface_methods' do
    it 'should make the basic form interface methods available on the form object' do
      expect(SomeForm.new).to implement_form_interface
    end
  end
end
