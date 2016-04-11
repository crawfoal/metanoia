require 'rails_helper'

RSpec.describe FlashHelper, type: :helper do
  describe '#render_flash' do
    it 'includes flash messages of types :alert, :notice, and :warning' do
      allow(helper).to receive(:flash).and_return(
        alert: 'This is an alert.',
        notice: 'This is a notice.',
        warning: 'This is a warning.'
      )
      expect(helper.render_flash).to include 'This is an alert.',
                                             'This is a notice.',
                                             'This is a warning.'
    end

    it "doesn't include message types that aren't whitelisted" do
      allow(helper).to receive(:flash).and_return(
        do_not_display_me: 'I should not be rendered.'
      )
      expect(helper.render_flash).to_not include 'I should not be rendered.'
    end

    it "doesn't render anything if there is no flash" do
      expect(helper.render_flash).to be_blank
    end

    it "doesn't include blank messages" do
      # make sure this spec breaks if "alert" is removed from whitelist
      allow(helper).to receive(:flash).and_return(alert: 'This is an alert.')
      expect(helper.render_flash).to include 'This is an alert.'

      allow(helper).to receive(:flash).and_return(alert: '')
      expect(helper.render_flash).to be_blank
    end
  end
end
