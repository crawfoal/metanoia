require 'rails_helper'

RSpec.describe 'layouts/_navbar.html.haml', type: :view do
  it "doesn't show the 'My Log' link when the current user's current role "\
     "isn't an athlete" do
    user = create :setter
    user.add_role :athlete
    allow(controller).to receive(:current_user).and_return(user)

    render

    expect(rendered).to_not have_link 'My Log'
  end
end
