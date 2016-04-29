require 'feature_helper'

RSpec.feature 'Athlete Climb Logs', type: :feature, js: true do
  scenario 'athlete logs a climb' do
    gym = create :gym, :with_named_section
    section = gym.sections.first
    v0 = section.climbs.create(attributes_for(:boulder, grade: 'V0'))
    v1 = section.climbs.create(attributes_for(:boulder, grade: 'V1'))
    user = create :athlete
    stubbed_sign_in user
    visit gym_path(gym)

    click_on section.name
    click_on 'V0'
    expect(page).to show_flash_with 'successfully logged'
    expect(user.athlete_story.climb_logs.count).to eq 1
    expect(user.athlete_story.climb_logs.first.climb_id).to eq v0.id

    click_on 'V1'
    wait_and_expect_ajax_to_finish
    expect(page).to have_selector('[class*="flash"]', count: 1)
  end
end
