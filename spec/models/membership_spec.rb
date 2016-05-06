require 'rails_helper'

RSpec.describe Membership, type: :model do
  it { should belong_to :athlete_story }
  it { should belong_to :gym }
end
