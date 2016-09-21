require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  before(:each) { set_devise_mapping }

  describe '#create' do
    context 'invalid params' do
      render_views

      it 'shows a customized error message' do
        params = {
          email: 'amanda@example.com',
          password: 'password',
          password_confirmation: 'wrong'
        }

        post :create, params: params

        expect(response.body).to include 'errors prevented you from signing up'
      end
    end
  end
end
