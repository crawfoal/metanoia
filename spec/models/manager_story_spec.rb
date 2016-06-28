require 'rails_helper'

RSpec.describe ManagerStory, type: :model do
  it { should belong_to :user }
  it { should have_many :employments }
end
