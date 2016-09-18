module Employable
  extend ActiveSupport::Concern

  included do
    has_many :employments, as: :role_story
    RoleStories.role_names << table_name.match(/(.+)_stories$/)[1].to_sym
    RoleStories.tables << table_name
    RoleStories.types << name
    # RoleStories.classes << self # for RoleStories.for_user, Rails 5
  end

  # tested through User#employed_at?
  def employed_at?(gym)
    employments.exists?(gym_id: gym)
  end

  module RoleStories
    @role_names = []
    @tables = []
    @types = []
    # @classes = [] # Rails 5

    class << self
      attr_accessor :role_names, :tables, :types#, :classes # Rails 5

      def type_to_role_name(type)
        type.underscore.split('_story').first
      end

      def types_to_role_names(types)
        types.map { |type| type_to_role_name(type) }
      end

      def tables_and_types
        tables.zip(types)
      end

      # Rails 5
      # def for_user(user)
      #   # like SetterStory.for_user(user).or(ManagerStory.for_user(user))
      #   classes.first.for_user(user).send_chain(*(
      #     classes[1,-1].map do |klass|
      #       [:or, klass.for_user(user)]
      #     end
      #   ))
      # end
    end
  end
end
