require 'rails_helper'

RSpec.describe GymsController, type: :controller do
  it { should route(:get, '/gyms/new').to(action: :new) }
  it { should route(:post, '/gyms').to(action: :create) }
  it { should route(:get, '/gyms').to(action: :index) }

  it 'uses strong parameters for #create' do
    params = {
      gym: attributes_for(
        :gym,
        :with_name,
        sections_attributes: (1..3).map { attributes_for(:section, :with_name) }
      )
    }

    expect(subject).to permit(:name, sections_attributes: [:name]).for(:create, params: params).on(:gym)
  end

  describe '#create' do
    context 'with invalid params' do
      it 're-renders the form' do
        skip 'no validations on gym model yet'
      end
    end
  end
end
