class GymForm
  delegate :name, :sections, :errors, :save, :persisted?, :model_name, :to_key, :to_model, to: :@gym

  def initialize(attribs_or_record = nil)
    if quacks_like_a_gym?(attribs_or_record)
      @gym = attribs_or_record
    else # assume it is a hash of attributes for a new record
      s_attribs = attribs_or_record.try(:delete, 'sections_attributes')
      @gym = Gym.new(attribs_or_record)
      self.sections_attributes = s_attribs if s_attribs
    end

    if @gym.sections.empty?
      @gym.sections << Section.new
    end
  end

  def sections_attributes=(set_of_attributes)
    set_of_attributes.each do |_index, attributes|
      destroy = attributes.delete('_destroy') == 'true'
      if destroy
        Section.find(attributes['id']).destroy if attributes['id']
        next
      end

      unless attributes['id']
        @gym.sections << Section.new(attributes)
        next
      end

      section = Section.find(attributes['id'])
      if section.gym_id.blank?
        section.gym_id = @gym.id
      elsif section.gym_id != @gym.id
        raise "Cannot assign #{section} to #{@gym} because it is already "\
              "assigned to another gym."
      end
      section.update(attributes)
    end
  end

  def update(attributes)
    s_attribs = attributes.try(:delete, 'sections_attributes')
    @gym.update(attributes)
    self.sections_attributes = s_attribs if s_attribs
  end

  private

  def quacks_like_a_gym?(object)
    [:name, :sections, :id].all? do |method_name|
      object.respond_to? method_name
    end
  end
end
