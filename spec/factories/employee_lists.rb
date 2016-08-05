FactoryGirl.define do
  factory :employee_list do
    initialize_with { new(create(:gym)) }
    skip_create
  end
end
