require 'rails_helper'

RSpec.describe GymsController, type: :controller do
  it { should route(:get, '/gyms/new').to(action: :new) }
  it { should route(:post, '/gyms').to(action: :create) }
  it { should route(:get, '/gyms').to(action: :index) }
  it { should route(:get, '/gyms/1').to(action: :show, id: 1) }
  it { should route(:get, '/gyms/1/edit').to(action: :edit, id: 1) }
  it { should route(:patch, '/gyms/1').to(action: :update, id: 1) }

  it 'should check authorization for #new' do
    pretend_not_authorized :new?

    get :new

    expect_standard_not_authorized_response
  end

  it 'should check authorization for #create' do
    pretend_not_authorized :create?

    post :create, params: { gym_form: attributes_for(:gym, :with_name) }

    expect_standard_not_authorized_response
  end

  it 'should check authorization for #edit' do
    pretend_not_authorized :edit?

    get :edit, params: { id: 1 }

    expect_standard_not_authorized_response
  end

  it 'should check authorization for #update' do
    pretend_not_authorized :update?

    get :update, params: { id: 1, gym_form: attributes_for(:gym, :with_name) }

    expect_standard_not_authorized_response
  end

  describe '#create' do
    it 'uses strong parameters' do
      create_and_login_user :admin
      params = { gym_form: build(:gym).attributes }

      expect(subject).to permit(
        :name,
        :route_grade_system_id,
        :boulder_grade_system_id,
        sections_attributes: [:id, :name, :_destroy]
      ).for(:create, params: params).on(:gym_form)
    end

    context 'when all params are blank and/or not present' do
      render_views

      it 're-renders the form' do
        create_and_login_user :admin

        post :create, params: params_for_gym_with_no_data

        expect(response).to render_template :new
      end
      it 'displays the error messages' do
        create_and_login_user :admin

        post :create, params: params_for_gym_with_no_data

        expect(response.body).to include_errors
      end
    end
  end

  describe '#update' do
    it do
      create_and_login_user :admin
      gym = build_stubbed :gym
      allow(Gym).to receive(:find).with(gym.id.to_s).and_return(gym)
      params = {
        id: gym.id,
        gym_form: attributes_for(:gym, :with_name)
      }

      should permit(
        :name,
        sections_attributes: [:id, :name, :_destroy]
      ).for(:update, params: params).on(:gym_form)
    end

    context 'when all params are blank and/or not present' do
      render_views

      it 're-renders the form', focus: true do
        create_and_login_user :admin
        gym = build_stubbed :gym
        allow(Gym).to receive(:find).with(gym.id.to_s).and_return(gym)

        patch :update, params: params_for_gym_with_no_data.merge(id: gym.id)

        expect(response).to render_template :edit
      end
      it 'displays the error messages' do
        create_and_login_user :admin
        gym = build_stubbed :gym
        allow(Gym).to receive(:find).with(gym.id.to_s).and_return(gym)

        patch :update, params: params_for_gym_with_no_data.merge(id: gym.id)

        expect(response.body).to include_errors
      end
    end
  end

  describe '#show' do
    it "doesn't include inactive climbs in the route histogram" do
      gym = create :gym, :with_named_section
      inactive_route = create :route, :with_grade, :not_active,
                              section: gym.sections.first

      get :show, params: { id: inactive_route.gym.id }

      rh_data_hash = Hash[assigns(:route_histogram).data]
      expect(rh_data_hash[inactive_route.grade.bucket.name]).to eq 0
    end

    it "doesn't include inactive climbs in the boulder histogram" do
      gym = create :gym, :with_named_section
      inactive_boulder = create :boulder, :with_grade, :not_active,
                                section: gym.sections.first

      get :show, params: { id: inactive_boulder.gym.id }

      rh_data_hash = Hash[assigns(:boulder_histogram).data]
      expect(rh_data_hash[inactive_boulder.grade.bucket.name]).to eq 0
    end
  end

  def params_for_gym_with_no_data
    {
      gym_form: attributes_for(
        :gym,
        name: '',
        sections_attributes: dup_and_build_nested_params(
          attributes_for(:section, name: ''), 3
        )
      )
    }
  end
end
