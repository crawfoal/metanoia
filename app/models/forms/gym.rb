module Forms
  class Gym
    include ActiveModel::Model
    include Virtus.model

    attribute :name, String
    attribute :sections, Array[Section]

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
      if valid?
        persist!
        true
      else
        false
      end
    end

    def sections_attributes=(set_of_attributes)
      self.sections ||= []
      set_of_attributes.each do |index, attributes_for_this_record|
        self.sections << Section.new(attributes_for_this_record)
      end
    end

    private

    def persist!
      @gym = ::Gym.create!(name: name, sections: self.sections)
    end
  end
end
