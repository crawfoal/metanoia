require 'rails_helper'

RSpec.describe ClimbLogger do
  let(:valid_params) do
    climb = create :climb
    { climb_id: climb.id }
  end

  let(:athlete) { create :athlete }

  describe '#log' do
    context 'with valid parameters for the climb_log' do
      it 'creates a new climb log' do
        expect { ClimbLogger.new(valid_params, athlete).log }.to \
          change { ClimbLog.count }.by(1)
      end

      it "creates a membership for the user and gym if one doesn't exist" do
        expect { ClimbLogger.new(valid_params, athlete).log }.to \
          change { Membership.count }.by(1)
      end

      it 'returns a truthy value' do
        expect(ClimbLogger.new(valid_params, athlete).log).to be_truthy
      end
    end

    context 'with invalid parameters for the climb log' do
      it "doesn't create a new climb log" do
        expect { ClimbLogger.new({}, athlete).log }.to_not \
          change { ClimbLog.count }
      end

      it "creates a membership for the user and gym if one doesn't exist" do
        expect { ClimbLogger.new({}, athlete).log }.to_not \
          change { Membership.count }
      end

      it 'returns a falsey value' do
        expect(ClimbLogger.new({}, athlete).log).to be_falsey
      end
    end

    context 'when the user has already logged a climb at that gym' do
      before :each do
        ClimbLogger.new(valid_params, athlete).log
        previous_climb = Climb.find(valid_params[:climb_id])
        another_climb = create :climb, section: previous_climb.section
        valid_params[:climb_id] = another_climb.id
      end

      it "doesn't create another membership record" do
        expect { ClimbLogger.new(valid_params, athlete).log }.to_not \
          change { Membership.count }
      end

      it 'returns a truthy value' do
        expect(ClimbLogger.new(valid_params, athlete).log).to be_truthy
      end
    end
  end
end
