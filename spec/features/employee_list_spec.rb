require 'feature_helper'

RSpec.feature 'Employee List', type: :feature, js: true do
  let(:employee_form) { PageObjects::EmployeeForm.on_page! }
  let(:employee_table) { PageObjects::EmployeeTable.on_page! }
  let(:gym) { create :gym }

  before :each do
    stubbed_sign_in create(:manager, employed_at: gym)
  end

  scenario 'admin or manager views employee list and adds a new setter' do
    setter = create :setter
    create :employment, gym: gym, role_story: setter.setter_story
    setter.add_role :manager
    create :employment, gym: gym, role_story: setter.manager_story

    visit gyms_path
    click_on 'Employee List'
    expect(employee_table).to list_employee setter, with_roles: :setter

    new_setter = create :setter
    employee_form.submit_with new_setter.attributes.merge(role: 'setter')

    wait_for_ajax
    expect(page).to show_flash_with 'New setter successfully added!'
    expect(employee_table).to list_employee new_setter, with_roles: :setter
    expect(employee_form.email).to be_blank
    expect(employee_form.role).to be_blank
  end

  scenario 'admin or manager adds a new manager (gets the email wrong on the '\
           'first try)' do
    visit gym_employments_path(gym)
    new_manager = create :manager
    employee_form.submit_with email: 'fake_email@example.com', role: 'manager'
    wait_for_ajax
    expect(page).to include_errors
    expect(employee_form.email).to eq 'fake_email@example.com'
    expect(employee_form.role).to eq 'manager'
    employee_form.submit_with new_manager.attributes.merge(role: 'manager')
    wait_for_ajax
    expect(page).to_not include_errors
    expect(employee_table).to list_employee new_manager, with_roles: :manager
  end

  scenario 'manager gives an existing employee a new role' do
    setter = create :setter
    create :employment, gym: gym, role_story: setter.setter_story
    visit gym_employments_path(gym)
    employee_form.submit_with setter.attributes.merge(role: 'manager')
    wait_for_ajax
    expect(employee_table).to \
      list_employee setter, with_roles: [:manager, :setter]
  end
end
