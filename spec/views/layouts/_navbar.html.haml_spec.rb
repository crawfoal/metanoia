require 'rails_helper'

RSpec.describe 'layouts/_navbar.html.haml', type: :view do
  it "doesn't show the 'My Log' link when the current user isn't an athlete" do
    allow(controller).to receive(:current_user).and_return(create(:visitor))

    render

    expect(rendered).to_not have_link 'My Log'
  end
end
