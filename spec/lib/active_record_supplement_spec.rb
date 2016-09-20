require 'rails_helper'

RSpec.describe ActiveRecordSupplement do
  describe '#pluck' do
    it 'returns an array of the requested attributes values, nested in another'\
       ' array (because this is how an AR collection with one element would '\
       'behave)' do
      climb = build :climb, color: '#b71c1c', type: 'Route'

      expect(climb.pluck(:color, :type)).to eq [['#b71c1c', 'Route']]
    end
  end
end
