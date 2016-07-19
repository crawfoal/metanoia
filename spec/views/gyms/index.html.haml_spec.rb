require 'rails_helper'

RSpec::Matchers.define :link_to_employee_list_for do |gym|
  match do |page|
    matched_row = page.find '#gyms tr', text: /.*#{gym.name}.*/
    matched_row.has_link? 'Employee List'
  end

  failure_message do |page|
    "expected \"#{page.native}\" to have link for #{gym.name}'s employee list"
  end

  failure_message_when_negated do |page|
    "expected \"#{page.native}\" to not have link for #{gym.name}'s employee list"
  end
end

RSpec.describe 'gyms/index.html.haml', type: :view do
  context "when the user's current role isn't admin" do
    it "doesn't show the link to create a new gym" do
      user = create :athlete
      user.add_role :admin
      allow(view).to receive(:current_user).and_return(user)
      assign(:gyms, create_list(:gym, 2))

      render

      expect(rendered).to_not have_selector '#new_gym'
    end
  end

  context 'when the current user is a manager' do
    it "only links to the employee list for the gym the user works at" do
      employer_gym = create :gym, name: 'Employer Gym'
      other_gym = create :gym, name: 'Other Gym'
      user = create :manager, employed_at: employer_gym
      allow(view).to receive(:current_user).and_return(user)
      assign(:gyms, [employer_gym, other_gym])

      render
      page = Capybara.string(rendered)

      expect(page).to link_to_employee_list_for employer_gym
      expect(page).to_not link_to_employee_list_for other_gym
    end
  end
end
