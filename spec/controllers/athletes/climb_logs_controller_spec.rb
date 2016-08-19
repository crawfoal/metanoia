require 'rails_helper'

RSpec.describe Athletes::ClimbLogsController, type: :controller do
  it { should route(:post, 'athletes/climb_logs').to(action: :create) }
  it { should route(:get, 'athletes/climb_logs').to(action: :index) }

  describe '#create' do
    it 'uses strong parameters' do
      login_user :athlete
      params = { climb_log: { climb_id: create(:climb).id }, format: 'js' }

      expect(subject).to permit(:climb_id).for(
        :create, params: params).on(:climb_log)
    end

    it 'sets a flash alert message when no climb is specified' do
      login_user :athlete
      params = {
        climb_log: { athlete_story_id: User.first.athlete_story.id },
        format: 'js'
      }

      xhr :post, :create, params

      expect(flash[:alert]).to be_present
    end

    it "sets a flash alert message and redirects back when the user isn't an "\
       'athlete' do
      login_user :setter
      params = { climb_log: { climb_id: create(:climb).id }, format: 'js' }
      request.env["HTTP_REFERER"] = 'starting_page'

      xhr :post, :create, params

      expect(response).to redirect_to 'starting_page'
      expect(flash[:alert]).to eq 'Sorry, only athletes have a climb log.'
    end
  end
end
