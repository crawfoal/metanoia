require 'rails_helper'

RSpec.describe ClimbsController, type: :controller do
  it do
    should route(:get, 'sections/1/climbs/new').to(action: :new, section_id: 1)
  end
  it do
    should route(:post, 'sections/1/climbs').to(action: :create, section_id: 1)
  end

  describe '#create' do
    it 'uses strong parameters' do
      params = {
        section_id: 1,
        climb: attributes_for(:climb, :with_grade, :with_color),
        format: 'js'
      }

      expect(subject).to permit(
        :section_id, :color, :type, :grade_id
      ).for(:create, params: params).on(:climb)
    end
  end
end
