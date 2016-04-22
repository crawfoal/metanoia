require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  it { should rescue_from(Pundit::NotAuthorizedError).with(:not_authorized) }
end
