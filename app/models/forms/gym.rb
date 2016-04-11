module Forms
  class Gym
    include ActiveModel::Model
    include Virtus.model

    attribute :name, String
    attribute :sections, Array[Section]

    validate :gym_cannot_be_blank

    def initialize(*args)
      super
      if sections.empty?
        self.sections = [Section.new]
      end
    end

    def persisted?
      false
    end

    def save
      build_models
      if valid?
        persist!
        true
      else
        false
      end
    end

    def sections_attributes=(set_of_attributes)
      self.sections ||= []
      set_of_attributes.each do |_index, attributes_for_this_record|
        self.sections << Section.new(attributes_for_this_record)
      end
    end

    def gym_cannot_be_blank
      unless @gym.value(reject_blanks: true).present?
        errors.add(:base, 'Cannot create a empty record for a gym. ' \
                          'You must define some information for the gym itself, '\
                          'or create some sections for the gym.')
      end
    end

    private

    def build_models
      sections = self.sections.select do |section|
        section.value(reject_blanks: true).present?
      end
      @gym = ::Gym.new(name: name, sections: sections)
    end

    def persist!
      build_models unless @gym
      @gym.save!
    end
  end
end
