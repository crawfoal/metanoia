require 'rails_helper'

RSpec.describe Bucket, type: :model do
  it { should belong_to :grade_system }
  it { should belong_to(:lower_bound_grade).class_name('Grade') }
  it { should belong_to(:upper_bound_grade).class_name('Grade') }
  it { should have_many(:grades) }
end
