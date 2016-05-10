require 'rails_helper'

RSpec.describe GradeSystem, type: :model do
  it { should have_many(:grades).dependent(:destroy).order(:order) }
  it { should validate_presence_of :name }
end
