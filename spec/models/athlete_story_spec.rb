require 'rails_helper'

RSpec.describe AthleteStory, type: :model do
  it { should belong_to :user }
  it { should validate_presence_of :user }
  it { should have_many :climb_logs }
  it { should have_many :memberships }
  it { should have_many :gyms }
end
