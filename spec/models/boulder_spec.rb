require 'rails_helper'

RSpec.describe Boulder, type: :model do
  it do
    should define_enum_for(:grade).with([
      'VB', 'V0', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'V7', 'V8', 'V9', 'V10',
      'V11', 'V12', 'V13', 'V14', 'V15', 'V16'
    ])
  end
end
