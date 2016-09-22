require 'rails_helper'

RSpec.describe ClimbsController, type: :controller do
  it do
    should route(:get, 'sections/1/climbs/new').to(action: :new, section_id: 1)
  end

  it do
    should route(:post, 'sections/1/climbs').to(action: :create, section_id: 1)
  end

  it 'should check authorization for #new' do
    pretend_not_authorized :new?

    get :new, xhr: true, params: { section_id: 1 }

    expect_standard_not_authorized_response
  end

  it 'should check authorization for #create' do
    pretend_not_authorized :create?

    post :create,
         xhr: true,
         params: { section_id: 1, climb: attributes_for(:climb) }

    expect_standard_not_authorized_response
  end

  describe '#create' do
    it do
      create_and_login_user :setter
      params = {
        section_id: 1,
        climb: attributes_for(:climb, :with_grade, :with_color),
        format: 'js'
      }

      should permit(
        :section_id, :color, :type, :grade_id, :teardown_date
      ).for(:create, params: params).on(:climb)
    end
  end
end
