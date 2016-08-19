require 'rails_helper'

RSpec.describe 'sections/_show.html.haml', type: :view do
  context 'for a non-setter user' do
    before :each do
      allow(controller).to receive(:current_user).and_return(create(:user))
      render 'sections/show.html.haml',
        section: create(:gym, :with_named_section).sections.first
    end

    it "doesn't show a link to add a new climb" do
      expect(rendered).to_not have_selector '.new-climb-link'
    end

    it "doesn't show a link to reset the section" do
      expect(rendered).to_not have_selector '#reset'
    end
  end

  context 'for a setter who does not work at the gym' do
    it 'does not show the "Add Climb" and "Reset Section" links' do
      setter = create :setter
      allow(controller).to receive(:current_user).and_return(setter)
      gym = create :gym, :with_named_section

      render 'sections/show.html.haml', section: gym.sections.first

      expect(rendered).to_not have_link 'Add Climb'
      expect(rendered).to_not have_selector '#reset'
    end
  end
end
