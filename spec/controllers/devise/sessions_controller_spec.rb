require 'rails_helper'

RSpec.describe Devise::SessionsController, type: :controller do
  describe '#create' do
    context 'invalid params' do
      render_views

      it 'displays a flash message' do
        set_devise_mapping

        post :create, email: 'amanda@example.com'

        expect(response.body).to include 'Invalid email or password.'
      end
    end
  end
end
