FactoryBot.define do
  factory :answer do
    sequence(:content) { |n| "test#{n}answer" }
    association :user
    association :question
    created_at {Time.zone.now}
  end
end
