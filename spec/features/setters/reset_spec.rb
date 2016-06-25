require 'feature_helper'

RSpec.feature 'Section Reset', type: :feature, js: true do
  scenario 'setter marks that they are resetting a section' do
    setter = create :setter
    gym = create :tiny_boulder_gym
    section = gym.sections.first
    stubbed_sign_in setter

    visit gym_path(gym)
    click_on section.name
    expect(page).to show_climbs(count: section.climbs.count)

    click_on 'Reset Section'
    wait_for_ajax(60)
    expect(page).to_not show_climbs

    click_on 'Add Climb'
    climb_form = PageObjects::Climbs::Form.on_page!
    climb_form.fill_with attributes_for(:boulder)
    climb_form.submit
    expect(page).to show_one_climb

    click_on 'Gyms'
    click_on section.gym.name
    click_on section.name
    expect(page).to show_one_climb
  end
end
