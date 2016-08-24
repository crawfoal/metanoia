require 'rails_helper'

RSpec.describe ClimbLogger do
  describe '#log' do
    context 'with valid parameters for the climb_log' do
      it 'creates a new climb log' do
        expect { build(:climb_logger).log }.to change { ClimbLog.count }.by(1)
      end

      it "creates a membership for the user and gym if one doesn't exist" do
        expect { build(:climb_logger).log }.to change { Membership.count }.by(1)
      end

      it 'returns a truthy value' do
        expect(build(:climb_logger).log).to be_truthy
      end
    end

    context 'with invalid parameters for the climb log' do
      it "doesn't create a new climb log" do
        climb_logger = build :climb_logger, :with_invalid_climb_log_params

        expect { climb_logger.log }.to_not change { ClimbLog.count }
      end

      it "doesn't create a membership for the user and gym" do
        climb_logger = build :climb_logger, :with_invalid_climb_log_params

        expect { climb_logger.log }.to_not change { Membership.count }
      end

      it 'returns a falsey value' do
        climb_logger = build :climb_logger, :with_invalid_climb_log_params

        expect(climb_logger.log).to be_falsey
      end
    end

    context 'when the user is already a member at that gym' do
      it "doesn't create another membership record" do
        climb_logger = build :climb_logger, :user_is_already_a_member_at_gym

        expect { climb_logger.log }.to_not change { Membership.count }
      end

      it 'returns a truthy value' do
        climb_logger = build :climb_logger, :user_is_already_a_member_at_gym

        expect(climb_logger.log).to be_truthy
      end
    end
  end
end
