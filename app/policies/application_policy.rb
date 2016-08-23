class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user || Visitor.new
    @record = record
  end

  def new?
    create?
  end

  def edit?
    update?
  end
end
