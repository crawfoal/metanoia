require 'rails_helper'

RSpec.describe SectionsController, type: :controller do
  it { should route(:get, '/sections/new').to(action: :new) }
  it { should route(:get, '/sections/1').to(action: :show, id: 1) }

  it 'should check authorization for #new' do
    pretend_not_authorized :new?

    xhr :get, :new
    
    expect_standard_not_authorized_response
  end
end
