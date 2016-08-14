require 'rails_helper'

RSpec.describe ClimbsController, type: :controller do
  it do
    should route(:get, 'sections/1/climbs/new').to(action: :new, section_id: 1)
  end

  it do
    should route(:post, 'sections/1/climbs').to(action: :create, section_id: 1)
  end

  let(:section) { create :section }
  let(:climb) { create :climb }

  it 'should check authorization for #new' do
    pretend_not_authorized :new?
    xhr :get, :new, section_id: section.id
    expect_standard_not_authorized_response
  end

  it 'should check authorization for #create' do
    pretend_not_authorized :create?
    xhr :post, :create, section_id: section.id
    expect_standard_not_authorized_response
  end

  describe '#create' do
    before(:each) { login_user :setter }

    it 'uses strong parameters' do
      params = {
        section_id: 1,
        climb: attributes_for(:climb, :with_grade, :with_color),
        format: 'js'
      }

      expect(subject).to permit(
        :section_id, :color, :type, :grade_id, :teardown_date
      ).for(:create, params: params).on(:climb)
    end
  end
end
