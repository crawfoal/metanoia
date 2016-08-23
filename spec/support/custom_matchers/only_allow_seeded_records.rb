RSpec::Matchers.define :only_allow_seeded_records do
  match do
    allow(Seedster).to receive(:migrating?).and_call_original

    expect { described_class.create! }.to \
      raise_error ActiveRecord::RecordNotSaved
    expect(Seedster).to have_received(:migrating?)
  end
end
