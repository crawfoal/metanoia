module HasNullObject
  extend ActiveSupport::Concern

  module ClassMethods
    def null_or_where(*args)
      where(*args).or(where(id: null_object_id))
    end

    def null_object
      find(null_object_id)
    end

    attr_accessor :null_object_id
    alias_method :null_object_id_is, :null_object_id=
  end
end
