module DatabaseAccessStubs
  def stub_find_for(*records)
    records.each do |record|
      allow(record.class).to receive(:find).with(record.id).and_return(record)
    end
  end
end

RSpec.configure do |config|
  config.include DatabaseAccessStubs
end
