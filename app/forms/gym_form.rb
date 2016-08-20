class GymForm < BaseForm
  delegate :route_grade_system_id, :boulder_grade_system_id, :name, to: :@gym
  delegate :persisted?, :valid?, :errors, to: :@gym
  attr_reader :sections

  def initialize(gym = nil)
    @gym = gym || Gym.new
    @sections = @gym.sections.to_a
  end

  def attributes=(attribs)
    s_attribs = attribs.delete('sections_attributes')
    @gym.attributes = attribs
    self.sections_attributes = s_attribs if s_attribs
  end

  def sections_attributes=(set_of_attributes)
    set_of_attributes.each do |_index, attributes|
      if attributes['id']
        section = get_section(attributes['id'])
      else
        section = Section.new
        sections << section
      end
      section.mark_for_destruction if attributes.delete('_destroy') == 'true'
      section.attributes = attributes
    end
  end

  def persist!
    associate_non_blank_sections_with_gym
    @gym.save!
  end

  def url
    if persisted?
      url_helpers.gym_path(@gym)
    else
      url_helpers.gyms_path
    end
  end

  def to_partial_path
    'gyms/form'
  end

  def add_section
    sections << Section.new
  end

  private

  def associate_non_blank_sections_with_gym
    @gym.sections = sections.select do |section|
      section.value(reject_blanks: true).present?
    end
  end

  def get_section(id)
    sections[sections.index { |section| section.id == id.to_i }]
  end
end
