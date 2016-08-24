require 'rails_helper'

RSpec.describe Visitor do
  it 'has a blank email' do
    expect(Visitor.new.email).to eq ''
  end

  it 'is not an admin' do
    expect(Visitor.new.is_admin?).to be false
  end

  it 'has a blank current_role' do
    expect(Visitor.new.current_role).to eq ''
  end

  it 'is not employed anywhere' do
    expect(Visitor.new.employed_at?).to be false
  end

  it 'does not have an athlete story' do
    expect(Visitor.new.athlete_story).to be_blank
  end
end
