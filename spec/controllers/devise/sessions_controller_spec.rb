require 'rails_helper'

RSpec.describe Devise::SessionsController, type: :controller do
  before(:each) { set_devise_mapping }

  describe '#create' do
    context 'invalid params' do
      render_views

      it 'displays a flash message' do
        post :create, email: 'amanda@example.com'

        expect(response.body).to include 'Invalid email or password.'
      end
    end
  end
end
