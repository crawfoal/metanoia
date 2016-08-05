require 'rails_helper'

RSpec.describe Visitor do
  let(:visitor) { Visitor.new }

  describe '#is_admin?' do
    it 'returns false' do
      expect(visitor.is_admin?).to be false
    end
  end

  describe '#email' do
    it 'returns a blank string' do
      expect(visitor.email).to eq ''
    end
  end
end
