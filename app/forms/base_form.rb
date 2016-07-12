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

  def save!
    if valid?
      persist!
    else
      opening = "The form is invalid due to the following errors:\n"
      error_message = errors.full_messages.reduce(opening) do |result, message|
        result += "\t#{message}\n"
      end
      raise(error_message)
    end
  end
end
