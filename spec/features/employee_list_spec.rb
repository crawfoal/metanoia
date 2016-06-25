require 'feature_helper'

RSpec.feature 'Employee List', type: :feature, js: true do
  scenario 'admin or manager views employee list and adds a new one' do
    gym = create :tiny_route_gym
    stubbed_sign_in create(:admin)

    visit gyms_path
    click_on 'Employee List'

    expect(page).to have_content "#{gym.name} Employees"
    expect(page).to have_selector 'th', text: 'Email'

    # TODO: page should list all employees

    # TODO: page should have option to add a new employee
  end
end
