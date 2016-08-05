require 'rails_helper'

class SomeForm < BaseForm
  def persist!
    true
  end

  def errors
    OpenStruct.new(
      full_messages: [
        'message 1',
        'message 2'
      ]
    )
  end
end

RSpec.describe BaseForm do
  let(:form) { SomeForm.new }

  describe '#save' do
    it 'calls `persist!` if the record is valid' do
      allow(form).to receive(:valid?).and_return(true)
      expect(form).to receive(:persist!)
      form.save
    end

    it 'returns a falsey value if the record is not valid' do
      allow(form).to receive(:valid?).and_return(false)
      expect(form.save).to be_falsey
    end
  end

  describe '#save!' do
    it 'calls `persist!` if the record is valid' do
      allow(form).to receive(:valid?).and_return(true)
      expect(form).to receive(:persist!)
      form.save!
    end

    it 'raises an error if the record is not valid' do
      allow(form).to receive(:valid?).and_return(false)
      expect { form.save! }.to \
        raise_error(/errors:\n\tmessage 1\n\tmessage 2\n/)
    end
  end
end
