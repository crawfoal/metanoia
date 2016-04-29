require 'rails_helper'

RSpec.describe 'sections/_show.html.haml', type: :view do
  context 'for a non-admin user' do
    it "doesn't show a link to add a new climb" do
      allow(view).to receive(:current_user).and_return(create(:user))
      def view.policy(model)
        Pundit.policy(current_user, model)
      end

      render 'sections/show.html.haml',
        section: create(:gym, :with_named_section).sections.first

      expect(rendered).to_not have_selector '.new-climb-link'
    end
  end
end
