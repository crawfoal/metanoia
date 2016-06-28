class BaseForm
  def self.delegate_basic_form_interface_methods(to:)
    delegate :name, :errors, :persisted?, :model_name, :to_key, :to_model,
             to: to
  end
end
