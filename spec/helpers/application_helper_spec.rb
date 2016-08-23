require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#render_as_local' do
    it "is a shortcut to calling render when the name of the local variable "\
       "should be the same as the instance variable's name" do
      employment_form = create(:employment_form)
      assign(:employment_form, employment_form)

      expect(helper.render_as_local(:employment_form)).to eq \
        helper.render(
          partial: 'employments/form',
          locals: { employment_form:  employment_form}
        ) # in the view/controller,     ^this is actually @employment_form
    end

    it "raises an error when the specified instance variable doesn't implement"\
       ' `to_partial_path`' do
      assign(:string, "I don't implement the correct interface")

      expect { helper.render_as_local :string }.to \
        raise_error(/doesn't implement `to_partial_path`/)
    end
  end
end
