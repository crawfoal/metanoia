require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#render_as_local' do
    it "raises an error when the specified instance variable doesn't implement"\
       ' `to_partial_path`' do
      assign(:string, "I don't implement the correct interface")
      expect { helper.render_as_local :string }.to \
        raise_error(/doesn't implement `to_partial_path`/)
    end
  end
end
