require 'feature_helper'

RSpec.feature 'Employee List', type: :feature, js: true do
  scenario 'admin or manager views employee list and adds a new one' do
    gym = create :tiny_route_gym
    setter = create :setter
    gym.employments.create(role_story: setter.setter_story)
    stubbed_sign_in create(:admin)

    visit gyms_path
    click_on 'Employee List'

    expect(page).to have_content "#{gym.name} Employees"

    expect(page).to have_selector 'tr', text: /#{setter.email}(.*)setter/

    # TODO: add new empoyee
  end
end
