class GymForm
  delegate :name, :errors, :persisted?, :model_name, :to_key, :to_model,
           to: :@gym
  attr_reader :sections

  # Loading in the whole sections association could be expensive if there were
  # a lot of records, but I'm not expecting that to be an issue in this case. If
  # it is, we can address it later. But think about it if I make a general form
  # object based on this one.
  def initialize(gym = nil)
    @gym = gym || Gym.new
    @sections = @gym.sections.to_a
    if @sections.empty?
      @sections << Section.new
    end
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

  def save
    @gym.sections = sections.select do |section|
      section.value(reject_blanks: true).present?
    end
    @gym.save
  end

  private

  def get_section(id)
    sections[sections.index { |section| section.id == id.to_i }]
  end
end
