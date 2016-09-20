class Tableless
  include ActiveModel::Model
  include ActiveRecord::Callbacks

  def initialize(*args)
    @new_record = true
    super(*args)
  end

  def save
    if valid?
      run_callbacks(:save) { true }
    else
      false
    end
  end

  def self.create!(*args)
    record = new(*args)
    if record.save!
      @new_record = false
    end
  end

  def save!
    save || raise(ActiveRecord::RecordNotSaved, "Failed to save the record")
  end

  def new_record?
    @new_record
  end
end
