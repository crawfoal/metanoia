require 'rails_helper'

RSpec.describe 'gyms/index.html.haml', type: :view do
  context 'for a non-admin user' do
    it "doesn't show the link to create a new gym" do
      allow(view).to receive(:current_user).and_return(Visitor.new)
      assign(:gyms, create_list(:gym, 2))
      render
      expect(rendered).to_not have_selector '#new_gym'
    end
  end
end
