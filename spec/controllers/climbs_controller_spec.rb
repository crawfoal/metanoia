require 'rails_helper'

RSpec.describe ClimbsController, type: :controller do
  it { should route(:get, '/climbs/new').to(action: :new) }
  it { should route(:post, '/climbs').to(action: :create) }

  describe '#create' do
    it 'uses strong parameters' do
      params = {
        climb: attributes_for(:climb, :with_grade, :with_color),
        format: 'js'
      }

      expect(subject).to permit(
        :section_id, :color, :type, :grade
      ).for(:create, params: params).on(:climb)
    end

    context 'when no section is specified' do
      render_views

      it 're-renders the form' do
        xhr :post, :create, climb: attributes_for(:climb)
        expect(response).to render_template :new, format: 'js'
      end

      it 'displays the error messages' do
        xhr :post, :create, climb: attributes_for(:climb)
        expect(response.body).to include_errors
      end
    end
  end
end
