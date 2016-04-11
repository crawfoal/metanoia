require 'rails_helper'

RSpec.describe SectionsController, type: :controller do
  it { should route(:get, '/sections/new').to(action: :new) }
end
