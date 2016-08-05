require 'rails_helper'

RSpec.describe SetterStory, type: :model do
  it { should belong_to :user }
  it { should have_many :employments }
end
