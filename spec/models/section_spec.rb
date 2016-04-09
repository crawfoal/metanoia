require 'rails_helper'

RSpec.describe Section, type: :model do
  it { should belong_to :gym }
end
