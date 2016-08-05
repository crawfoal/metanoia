require 'view_helper'

RSpec.describe 'gyms/index.html.haml', type: :view do
  context "when the user's current role isn't admin" do
    it "doesn't show the link to create a new gym" do
      user = create :athlete
      user.add_role :admin
      allow(controller).to receive(:current_user).and_return(user)
      assign(:gyms, create_list(:gym, 2))

      render

      expect(rendered).to_not have_selector '#new_gym'
    end
  end

  context 'when the current user is a manager' do
    it 'only links to the employee list for the gym the user works at' do
      employer_gym = create :gym, name: 'Employer Gym'
      other_gym = create :gym, name: 'Other Gym'
      user = create :manager, employed_at: employer_gym
      allow(controller).to receive(:current_user).and_return(user)
      assign(:gyms, [employer_gym, other_gym])

      render
      index_page = PageObjects::Gyms::Index.from_string!(rendered)

      expect(index_page).to have_employee_list_link_for employer_gym
      expect(index_page).to_not have_employee_list_link_for other_gym
    end
  end
end
