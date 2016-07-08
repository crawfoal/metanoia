class BaseForm
  def self.inherited(subclass)
    subclass.include(ActiveModel::Naming)
    subclass.include(ActiveModel::Conversion)
    subclass.include(ActiveModel::Validations)
    subclass.delegate :url_helpers, to: 'Rails.application.routes'
  end

  def save
    valid? ? persist! : false
  end

  # TODO: use errors instead of generic message
  def save!
    valid? ? persist! : raise('Form not valid!')
  end
end
