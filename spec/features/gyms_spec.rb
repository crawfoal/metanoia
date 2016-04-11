require "feature_helper"

RSpec.feature "Gyms", type: :feature, js: true do
  scenario "(admin) creates a gym" do
    visit new_gym_path
    gym_form = PageObjects::Gyms::Form.on_page!

    expect(gym_form).to have_fields_for_one_section

    gym_form.set_gym_name_to 'Wild Walls'
    gym_form.set_first_section_name_to 'The Cave'
    gym_form.add_fields_for_another_gym
    expect(gym_form).to have_fields_for_2_sections

    gym_form.set_next_section_name_to 'The Slab'
    gym_form.submit

    index_page = PageObjects::Gyms::Index.on_page!
    expect(page).to have_flash_with_content 'success'
    expect(index_page).to have_gym 'Wild Walls'

    ww = Gym.find_by_name('Wild Walls')
    expect(ww).to be_present
    ['The Cave', 'The Slab'].each do |section_name|
      section = ww.sections.find_by_name section_name
      expect(section).to be_present
    end
  end
end
