require 'rails_helper'

RSpec.describe Role, type: :model do
  it { should have_and_belong_to_many(:users).join_table('users_roles') }
  it { should belong_to :resource }
  it { should validate_inclusion_of(:resource_type).in_array(Rolify.resource_types) }
  it { should only_allow_seeded_records }
end
