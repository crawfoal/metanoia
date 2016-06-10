require 'rails_helper'

RSpec.describe 'gyms/show.html.haml', type: :view do
  context 'for a non-admin user' do
    it "doesn't show the link to edit the gym" do
      allow(view).to receive(:current_user).and_return(Visitor.new)
      gym = create(:gym)
      assign(:gym, gym)
      assign(:route_histogram, ClimbHistogram.new(gym.routes, gym.route_grade_system))
      assign(:boulder_histogram, ClimbHistogram.new(gym.boulders, gym.boulder_grade_system))
      render
      expect(rendered).to_not have_selector '.edit-gym-link'
    end
  end

  context "when the gym doesn't have any climbs" do
    it "doesn't include the .route-histogram or .boulder-histogram divs" do
      athlete = create :athlete
      allow(view).to receive(:current_user).and_return(athlete)
      gym = create :gym
      assign(:gym, gym)
      assign(:route_histogram, ClimbHistogram.new(gym.routes, gym.route_grade_system))
      assign(:boulder_histogram, ClimbHistogram.new(gym.boulders, gym.boulder_grade_system))
      render
      expect(rendered).to_not have_selector '.route-histogram'
      expect(rendered).to_not have_selector '.boulder-histogram'
    end
  end
end
