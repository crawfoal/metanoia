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
    expect(page).to_not show_climbs

    reload_page
    expect(page).to_not show_climbs
  end

  def show_climbs(options = {})
    have_selector "#climbs .button_to", options
  end
end
