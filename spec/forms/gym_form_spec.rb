require 'rails_helper'

RSpec.describe GymForm do
  it { should implement_form_interface }

  describe '#initialize' do
    context 'when given no arguments' do
      it 'builds a new gym with one section' do
        gym_form = GymForm.new

        expect(gym_form.sections.size).to eq 1
        expect(gym_form.sections.first).to be_a_new_record
      end
    end

    context 'when given a gym record' do
      it "makes the record's attributes available through the form object" do
        gym = build :gym, :with_name, :with_named_section
        gym_form = GymForm.new(gym)

        expect(gym_form.name).to eq gym.name
        expect(gym_form).to have_section_named gym.sections.first.name
      end
    end
  end

  describe '#attributes=' do
    it 'sets the given attributes on the gym record' do
      gym_form = GymForm.new
      gym_form.attributes = {
        'name' => 'Wild Walls',
        'sections_attributes' => { '1' => { 'name' => 'The Cave' } }
      }

      expect(gym_form.name).to eq 'Wild Walls'
      expect(gym_form).to have_section_named 'The Cave'
    end
  end

  describe '#sections_attributes=' do
    it 'updates (in memory, not the db) sections that have an id, otherwise '\
       'builds a new section' do
      gym = create :gym, section_names: ['Original Name']
      gym_form = GymForm.new(gym)

      gym_form.sections_attributes = {
        '1' => { 'name' => 'The Cave' },
        '2' => { 'id' => gym.section_ids.first, 'name' => 'Updated Name' }
      }

      expect(gym_form).to have_sections_named 'The Cave', 'Updated Name'
    end

    it "marks section for destruction if they specify 'true' for `_destroy`" do
      gym = create :gym, :with_named_section
      gym_form = GymForm.new(gym)

      gym_form.sections_attributes = {
        '1' => { 'id' => gym.section_ids.first, '_destroy' => 'true' }
      }

      expect(gym_form.sections.first).to be_marked_for_destruction
    end
  end

  describe '#save' do
    it 'saves the gym with all of the sections' do
      gym = create :gym, section_names: ['Original Name']
      gym_form = GymForm.new(gym)

      gym_form.attributes = { 'name' => 'New Gym Name' }
      gym_form.sections_attributes = {
        '1' => { 'name' => 'The Cave' },
        '2' => { 'id' => gym.section_ids.first, 'name' => 'Updated Name' }
      }
      gym_form.save

      gym.reload
      expect(gym.name).to eq 'New Gym Name'
      expect(gym).to have_sections_named 'The Cave', 'Updated Name'
    end

    it "destroys (or doesn't save) records marked for destruction" do
      gym = create :gym, section_names: ['Section Name']
      gym_form = GymForm.new(gym)

      gym_form.sections_attributes = {
        '1' => { 'id' => gym.section_ids.first, '_destroy' => 'true' },
        '2' => { 'name' => 'I will not be saved.', '_destroy' => 'true' }
      }
      gym_form.save

      gym.reload
      expect(gym.sections).to be_empty
    end

    it "doesn't save sections that have a blank value" do
      gym = create :gym, :with_name
      gym_form = GymForm.new(gym)

      gym_form.sections_attributes = {
        '1' => { 'name' => '' }
      }
      gym_form.sections << Section.new
      gym_form.save

      expect(gym.sections).to be_empty
    end
  end

  it 'responds to methods that the form builder needs' do
    gym_form = GymForm.new
    [:persisted?, :model_name, :to_key, :to_model].each do |method_name|
      expect(gym_form).to respond_to method_name
    end
  end
end
