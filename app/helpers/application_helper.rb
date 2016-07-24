module ApplicationHelper
  def render_as_local(instance_variable_name)
    object = instance_variable_get("@#{instance_variable_name}")
    unless object.respond_to? :to_partial_path
      raise "Error: #{object} doesn't implement `to_partial_path`"
    end
    render partial: object.to_partial_path,
      locals: { instance_variable_name.to_sym => object }
  end
end
