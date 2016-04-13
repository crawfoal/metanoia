require 'rails_helper'

RSpec.describe GymForm do
  describe '#initialize' do
    context 'when given no arguments' do
      it 'builds a new gym with one section' do
        gym_form = GymForm.new

        expect(gym_form.name).to be_blank
        expect(gym_form.sections.size).to eq 1
        expect(gym_form.sections.first).to be_a_new_record
      end
    end

    context 'when given a hash of attributes' do
      it 'builds a new gym with those attributes' do
        gym_form = GymForm.new(
          'name' => 'Wild Walls',
          'sections_attributes' => { '1' => { 'name' => 'The Cave' } }
        )

        expect(gym_form.name).to eq 'Wild Walls'
        expect(gym_form.sections.first.name).to eq 'The Cave'
      end
    end

    context 'when given a gym record' do
      it "makes the record's attributes available through the form object" do
        gym = Gym.new(
          name: 'Wild Walls',
          sections: [Section.new(name: 'The Cave')]
        )

        gym_form = GymForm.new(gym)

        expect(gym_form.name).to eq 'Wild Walls'
        expect(gym_form.sections.first.name).to eq 'The Cave'
      end
    end
  end

  describe '#sections_attributes' do
    context 'when none of the attribute hashes contain an id' do
      it 'creates new sections for each of the hashes' do
        gym_form = GymForm.new
        section_names = ['The Cave', 'The Slab']

        gym_form.sections_attributes = {
          '1' => { 'name' => section_names[0] },
          '2' => { 'name' => section_names[1] }
        }

        gym_form.sections.each do |section|
          expect(section).to be_a_new_record
          section_names.delete section.name
        end
        expect(section_names).to be_empty
      end
    end

    context 'when one of the hashes contains an id for a section that does not belong a gym yet' do
      it 'updates sections that have an id and assigns them to the gym, otherwise creates a new section' do
        gym = create :gym
        gym_form = GymForm.new(gym)
        section = create(:section, name: 'Original Name')

        gym_form.sections_attributes = {
          '1' => { 'name' => 'The Cave' },
          '2' => { 'id' => section.id, 'name' => 'Updated Name'}
        }

        section.reload
        expect(section.name).to eq 'Updated Name'
        expect(section.gym_id).to eq gym.id
        the_cave_is_added = gym_form.sections.any? do |section|
          section.name == 'The Cave'
        end
        expect(the_cave_is_added).to be true
      end
    end

    context 'when one of the hashes contains an id for a section that belongs to the gym attached to the form' do
      it 'updates sections that have an id, otherwise creates a new section' do
        gym = create :gym, section_names: ['Original Name']
        section = gym.sections.first
        gym_form = GymForm.new(gym)

        gym_form.sections_attributes = {
          '1' => { 'name' => 'The Cave' },
          '2' => { 'id' => section.id, 'name' => 'Updated Name', '_destroy' => 'false'}
        }

        section.reload
        expect(section.name).to eq 'Updated Name'
        expect(section.gym_id).to eq gym.id
        the_cave_is_added = gym_form.sections.any? do |section|
          section.name == 'The Cave'
        end
        expect(the_cave_is_added).to be true
      end
    end

    context 'when one of the hashes contains an id for a section that already belongs to another gym' do
      it 'raises an error' do
        gym = create :gym, section_names: ['Original Name']
        section = gym.sections.first
        gym_form = GymForm.new

        expect do
          gym_form.sections_attributes = {
            '1' => { 'id' => section.id, 'name' => 'Updated Name'}
          }
        end.to raise_error /Cannot assign .* because it is already assigned to another gym./
      end
    end

    context 'when one of the hashes specifies that the section should be destroyed' do
      it 'destroys the section' do
        gym = create :gym, section_names: ['Section Name']
        section = gym.sections.first
        gym_form = GymForm.new(gym)

        expect { gym_form.sections_attributes = { '1' => { 'id' => section.id, '_destroy' => 'true' } } }.to change { Section.count }.by(-1)
      end
    end
  end

  it 'responds to `#persisted?`, `#model_name`, `#to_key`, and `#to_model` so that the form builder sets the HTTP method and other attributes correctly' do
    gym_form = GymForm.new
    [:persisted?, :model_name, :to_key, :to_model].each do |method_name|
      expect(gym_form).to respond_to method_name
    end
  end
end
