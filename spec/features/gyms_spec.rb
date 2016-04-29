require "feature_helper"

RSpec.feature "Gyms", type: :feature, js: true do
  scenario "(admin) creates a gym" do
    stubbed_sign_in create(:admin)
    visit new_gym_path
    gym_form = PageObjects::Gyms::Form.on_page!

    expect(gym_form).to have_fields_for_one_section

    gym_form.gym_name = 'Wild Walls'
    gym_form.first_section_name = 'The Cave'
    gym_form.add_fields_for_another_section
    expect(gym_form).to have_fields_for_2_sections

    gym_form.next_section_name = 'The Slab'
    gym_form.add_fields_for_another_section
    expect(gym_form).to have_fields_for_3_sections

    gym_form.delete_nth_section(2)
    expect(gym_form).to have_fields_for_2_sections

    gym_form.next_section_name = 'The Slab'
    gym_form.submit

    expect(page).to show_flash_with 'success'
    index_page = PageObjects::Gyms::Index.on_page!
    expect(index_page).to have_gym 'Wild Walls'

    ww = Gym.find_by_name('Wild Walls')
    expect(ww).to be_present
    expect(ww.sections.size).to eq 2
    ['The Cave', 'The Slab'].each do |section_name|
      section = ww.sections.find_by_name section_name
      expect(section).to be_present
    end
  end

  scenario '(admin) views and edits a gym' do
    section_names = ['Section 1', 'Section 2', 'Section 3']
    gym = create(
      :gym,
      :with_name,
      section_names: section_names
    )
    stubbed_sign_in create(:admin)

    visit gyms_path
    click_on gym.name
    expect(page).to have_content gym.name
    section_names.each do |section_name|
      expect(page).to have_content section_name
    end
    click_on 'Edit Gym Info'

    gym_form = PageObjects::Gyms::Form.on_page!
    expect(gym_form).to have_fields_for_3_sections

    gym_form.delete_nth_section(2)
    gym_form.submit

    expect(page).to show_flash_with 'success'
    gym.reload
    expect(gym.sections.size).to eq 2
  end
end
