require 'rails_helper'

RSpec.describe ClimbLog, type: :model do
  it { should belong_to :athlete_story }
  it { should belong_to :climb }
  it { should validate_presence_of :athlete_story  }
  it { should validate_presence_of :climb  }
end
