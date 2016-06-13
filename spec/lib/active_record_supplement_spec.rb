require 'rails_helper'

RSpec.describe ActiveRecordSupplement do
  describe '#pluck' do
    it 'returns an array of the requested attributes values, nested in another'\
       ' array' do
      climb = build :climb, color: 1, type: 'Route'
      expect(climb.pluck(:color, :type)).to eq [[1, 'Route']]
    end
  end
end
