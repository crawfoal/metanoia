require 'feature_helper'

RSpec.feature 'Employee List', type: :feature, js: true do
  def page_should_show(employee, with_role: nil)
    expect(page).to have_content /#{employee.email}#{role_regex(with_role)}/
  end

  def role_regex(role_names)
    _role_names = Array(role_names)
    regex = _role_names.reduce('(') do |regex, role_name|
      regex += "[^@]*#{role_name}|"
    end
    regex = regex[0..-2] + "){#{_role_names.size}}"
  end

  before :each do
    stubbed_sign_in create(:admin)
  end

  let(:gym) { create :gym }

  scenario 'admin or manager views employee list and adds a new setter' do
    setter = create :setter
    gym.employments.create(role_story: setter.setter_story)
    setter.add_role :manager
    gym.employments.create(role_story: setter.manager_story)

    visit gyms_path
    click_on 'Employee List'

    expect(page).to have_content "#{gym.name} Employees"
    page_should_show setter, with_role: :setter

    new_setter = build :setter
    fill_in "Employee's Email", with: new_setter.email
    select 'setter', from: 'Role'
    click_on 'Add'

    expect(page).to show_flash_with 'New setter successfully added!'
    page_should_show new_setter, with_role: :setter
    expect(page).to_not have_field "Employee's Email", with: new_setter.email
    expect(page).to_not have_select 'Role', selected: 'setter'
  end

  scenario 'admin or manager adds a new manager' do
    visit gym_employments_path(gym)
    new_manager = create :manager
    fill_in "Employee's Email", with: new_manager.email
    select 'manager', from: 'Role'
    click_on 'Add'

    page_should_show new_manager, with_role: :manager
  end
end
