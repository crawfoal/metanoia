require 'rails_helper'

RSpec.describe Visitor do
  describe '#is_admin?' do
    it 'returns false' do
      visitor = Visitor.new
      expect(visitor.is_admin?).to be false
    end
  end
end
