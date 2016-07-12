require 'feature_helper'

RSpec.feature 'Employee List', type: :feature, js: true do
  def page_should_show(employee, with_roles: nil)
    wait_for_ajax(10)
    el_text = page.find('#employee_list').text
    match_data = el_text.match(/#{employee.email}#{role_regex(with_roles)}/)
    num_roles_listed = match_data.present? ? match_data.to_a[1..-1].compact.size : 0
    expect(num_roles_listed).to eq(Array(with_roles).size),
      "expected \n\n\t#{el_text}\n\nto include #{employee.email} with roles "\
      "#{Array(with_roles).to_sentence}"
  end

  def role_regex(role_names)
    _role_names = Array(role_names)
    regex = _role_names.reduce('.*(?:') do |regex, role_name|
      regex += "[, ]+(#{role_name})|"
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
    page_should_show setter, with_roles: :setter

    new_setter = build :setter
    fill_in "Employee's Email", with: new_setter.email
    select 'setter', from: 'Role'
    click_on 'Add'

    expect(page).to show_flash_with 'New setter successfully added!'
    page_should_show new_setter, with_roles: :setter
    expect(page).to_not have_field "Employee's Email", with: new_setter.email
    expect(page).to_not have_select 'Role', selected: 'setter'
  end

  scenario 'admin or manager adds a new manager' do
    visit gym_employments_path(gym)
    new_manager = create :manager
    fill_in "Employee's Email", with: new_manager.email
    select 'manager', from: 'Role'
    click_on 'Add'

    page_should_show new_manager, with_roles: :manager
  end

  scenario 'manager gives an existing employee a new role' do
    setter = create :setter
    gym.employments.create(role_story: setter.setter_story)
    visit gym_employments_path(gym)
    fill_in "Employee's Email", with: setter.email
    select 'manager', from: 'Role'
    click_on 'Add'
    page_should_show setter, with_roles: [:manager, :setter]
    expect(page).to have_selector '.email', text: setter.email, count: 1
  end

  scenario "manager tries to add a new employee, but the user isn't registered" do
    visit gym_employments_path(gym)
    fill_in "Employee's Email", with: 'not_a_real_email@example.com'
    select 'manager', from: 'Role'
    click_on 'Add'

    expect(page).to include_errors
    expect(page).to have_field "Employee's Email", with: 'not_a_real_email@example.com'
    expect(page).to have_select 'Role', selected: 'manager'
  end
end
