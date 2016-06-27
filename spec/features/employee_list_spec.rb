require 'feature_helper'

RSpec.feature 'Employee List', type: :feature, js: true do
  def page_should_show(employee, with_role: nil)
    expect(page).to have_selector 'tr', text: /#{employee.email}(.*)#{with_role}/
  end

  scenario 'admin or manager views employee list and adds a new one' do
    gym = create :tiny_route_gym
    setter = create :setter
    gym.employments.create(role_story: setter.setter_story)
    stubbed_sign_in create(:admin)

    visit gyms_path
    click_on 'Employee List'

    expect(page).to have_content "#{gym.name} Employees"
    page_should_show setter, with_role: :setter

    new_setter = build :setter
    fill_in 'Email', with: new_setter.email
    select 'setter', from: 'employment_role_name'
    click_on 'Add'

    expect(page).to show_flash_with 'New setter successfully added!'
    page_should_show new_setter, with_role: :setter
  end
end
