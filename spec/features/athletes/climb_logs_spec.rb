require 'feature_helper'

RSpec.feature 'Athlete Climb Logs', type: :feature, js: true do
  scenario 'athlete logs some climbs, then views all of their logged climbs' do
    user = create :athlete
    gyms = [
      create(:tiny_boulder_gym),
      create(:tiny_route_gym)
    ]
    stubbed_sign_in user

    gyms.each do |gym|
      visit gym_path(gym)
      click_on gym.sections.first.name
      expect do
        first('#climbs a').click
        wait_for_ajax
      end.to change { user.athlete_story.climb_logs.count }.by(1)
      expect(page).to show_flash_with 'successfully logged'
      expect(page).to have_selector('[class*="flash"]', count: 1)
    end

    click_on 'My Log'
    logs_index_page = PageObjects::ClimbLogs::Index.on_page!
    original_gym_name = logs_index_page.current_gym_name
    expect(logs_index_page).to be_showing_valid_gym_section_and_logs_for user

    logs_index_page.next_gym
    expect(logs_index_page.current_gym_name).to_not eq original_gym_name
    expect(logs_index_page).to be_showing_valid_gym_section_and_logs_for user
  end
end
