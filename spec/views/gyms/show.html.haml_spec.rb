require 'rails_helper'

RSpec.describe 'gyms/show.html.haml', type: :view do
  context 'for a non-admin user' do
    it "doesn't show the link to edit the gym" do
      allow(view).to receive(:current_user).and_return(Visitor.new)
      assign(:gym, build_stubbed(:gym))
      assign(:route_histogram, build(:climb_histogram, :empty_stub))
      assign(:boulder_histogram, build(:climb_histogram, :empty_stub))

      render

      expect(rendered).to_not have_selector '.edit-gym-link'
    end
  end

  context "when the gym doesn't have any climbs" do
    it "doesn't include the .route-histogram or .boulder-histogram divs" do
      allow(view).to receive(:current_user).and_return(build_stubbed(:athlete))
      assign(:gym, build_stubbed(:gym))
      assign(:route_histogram, build(:climb_histogram, :empty_stub))
      assign(:boulder_histogram, build(:climb_histogram, :empty_stub))

      render
      
      expect(rendered).to_not have_selector '.route-histogram'
      expect(rendered).to_not have_selector '.boulder-histogram'
    end
  end
end
