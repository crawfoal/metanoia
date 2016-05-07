require 'rails_helper'

RSpec.describe Grade, type: :model do
  it { should belong_to :grade_system }
  it { should validate_presence_of :name }
  it { should validate_presence_of :grade_system }
end
