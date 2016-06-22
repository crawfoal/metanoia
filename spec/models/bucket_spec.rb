require 'rails_helper'

RSpec.describe Bucket, type: :model do
  it { should belong_to :grade_system }
  it { should have_many(:grades) }
end
