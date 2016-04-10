module ParamsHelper
  def dup_and_build_nested_params(attribs_for_one_record, count)
    (1..count).map{ |index| [index.to_s, attribs_for_one_record] }.to_h
  end
end

RSpec.configure do |config|
  config.include ParamsHelper
end
