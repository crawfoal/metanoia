require 'rails_helper'

RSpec.describe ClimbHelper, type: :helper do
  describe '#data_for_color_options' do
    it 'returns an array of name - hex value pairs for the color options' do
      result = helper.data_for_color_options

      expect(result).to be_present
      result.each do |name, hex|
        expect(name).to eq Climb.color_name_for(hex)
        expect(hex).to be_in Climb::COLORS
      end
    end
  end
end
