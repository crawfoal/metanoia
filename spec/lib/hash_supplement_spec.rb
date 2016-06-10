require 'rails_helper'

RSpec.describe HashSupplement do
  describe '#first_key' do
    it 'returns the first key of the hash' do
      h = {a: 1, b: 2, c: 3}
      expect(h.first_key).to eq :a
    end
  end
end
