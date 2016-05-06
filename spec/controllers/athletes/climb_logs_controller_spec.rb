require 'rails_helper'

RSpec.describe Athletes::ClimbLogsController, type: :controller do
  it { should route(:post, 'athletes/climb_logs').to(action: :create) }
  it { should route(:get, 'athletes/climb_logs').to(action: :index) }

  before :each do
    login_user :athlete
  end

  describe '#create' do
    it 'uses strong parameters' do
      climb = create :climb
      params = {
        climb_log: {
          athlete_story_id: User.first.athlete_story.id,
          climb_id: climb.id
        },
        format: 'js'
      }

      expect(subject).to permit(:climb_id).for(
        :create, params: params).on(:climb_log)
    end

    context 'when no climb is specified' do
      it 'sets a flash alert message' do
        params = {
          climb_log: { athlete_story_id: User.first.athlete_story.id },
          format: 'js'
        }
        xhr :post, :create, params

        expect(flash[:alert]).to be_present
      end
    end
  end
end
