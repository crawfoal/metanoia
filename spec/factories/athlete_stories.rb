FactoryGirl.define do
  factory :athlete_story do
    before :create do |athlete_story|
      unless athlete_story.user
        athlete_story.user = create :user
      end
    end
  end
end
