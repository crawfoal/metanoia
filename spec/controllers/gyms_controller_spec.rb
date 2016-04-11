require 'rails_helper'

RSpec.describe GymsController, type: :controller do
  it { should route(:get, '/gyms/new').to(action: :new) }
  it { should route(:post, '/gyms').to(action: :create) }
  it { should route(:get, '/gyms').to(action: :index) }

  it 'uses strong parameters for #create' do
    params = {gym: attributes_for(:gym, :with_name)}

    expect(subject).to permit(:name, sections_attributes: [:name]).for(:create, params: params).on(:gym)
  end

  describe '#create' do
    it "doesn't add sections that don't have names, since that is the only attribute for the seciton model so far" do
      params = {
        gym: attributes_for(
          :gym,
          name: nil,
          sections_attributes: dup_and_build_nested_params(attributes_for(:section, name: ''), 3)
        )
      }

      expect{post :create, params}.to_not change{Section.count}
    end

    context 'when all params are blank and/or not present' do
      render_views

      it 're-renders the form', focus: true do
        post :create, params_for_gym_with_no_data
        expect(response).to render_template :new
      end
      it 'displays the error messages' do
        post :create, params_for_gym_with_no_data
        expect(response.body).to include_errors
      end
    end
  end

  def params_for_gym_with_no_data
    {
      gym: attributes_for(
        :gym,
        name: '',
        sections_attributes: dup_and_build_nested_params(attributes_for(:section, name: ''), 3)
      )
    }
  end
end
