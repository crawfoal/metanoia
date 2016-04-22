require 'rails_helper'

RSpec.describe 'gyms/show.html.haml', type: :view do
  context 'for a non-admin user' do
    it "doesn't show the link to edit the gym" do
      allow(view).to receive(:current_user).and_return(Visitor.new)
      assign(:gym, create(:gym))
      render
      expect(rendered).to_not have_selector '.edit-gym-link'
    end
  end
end
