require 'rails_helper'

RSpec.describe Section, type: :model do
  it { should belong_to :gym }
  it { should extract_value_from :name }
end
