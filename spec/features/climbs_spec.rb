require 'feature_helper'

RSpec.feature 'Climbs', type: :feature, js: true do
  scenario '(setter) creates a new climb' do
    gym = create(
      :gym,
      :with_name,
      section_names: ['Section 1', 'Section 2', 'Section 3']
    )

    visit gyms_path
    click_on gym.name
    click_on 'Section 2'
    click_on 'Enter New Climb'

    climb_form = PageObjects::Climbs::Form.on_page!
    expect(climb_form).to be_for_section 'Section 2'

    climb_form.choose_route
    climb_form.grade = '5.11b'
    climb_form.color = 'Pink'
    climb_form.submit

    expect(page).to show_flash_with 'success'
    page_should_replace_form_with_section_overview
    page_should_have_climb '5.11b', 'Pink'
  end

  def page_should_replace_form_with_section_overview
    expect(page).to_not have_button 'Save'
    expect(page).to have_link 'Enter New Climb'
    expect(page).to have_selector('#current_section', count: 1)
  end

  def page_should_have_climb(grade, color)
    expect(page).to have_selector 'a.pink', text: '5.11b'
  end
end
