require 'feature_helper'

RSpec.feature 'Athlete Climb Logs', type: :feature, js: true do
  scenario 'athlete logs a climb, then views all of their logged climbs' do
    gym = create :gym, :with_name, :with_named_section
    section = gym.sections.first
    v0 = section.climbs.create(attributes_for(:boulder, grade: 'V0'))
    v1 = section.climbs.create(attributes_for(:boulder, grade: 'V1'))
    section2 = gym.sections.create(attributes_for(:section, name: 'Section 2'))
    v2 = section2.climbs.create(attributes_for(:boulder, grade: 'V2'))
    gym2 = create :gym, :with_named_section, name: 'Gym 2'
    section3 = gym2.sections.first
    v3 = section3.climbs.create(attributes_for(:boulder, grade: 'V3'))

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
    expect(user.athlete_story.climb_logs.count).to eq 2
    expect(page).to have_selector('[class*="flash"]', count: 1)

    click_on 'Section 2'
    click_on 'V2'
    wait_and_expect_ajax_to_finish

    visit gym_path(gym2)
    click_on section3.name
    click_on 'V3'

    click_on 'My Log'
    find('.section .fa-caret-right').click
    expect(page).to have_content gym.name
    expect(page).to have_content section.name
    expect(page).to have_content 'V0'
    expect(page).to have_content 'V1'

    find('.section .fa-caret-left').click
    expect(page).to have_content section2.name
    expect(page).to have_content 'V2'
  end
end
