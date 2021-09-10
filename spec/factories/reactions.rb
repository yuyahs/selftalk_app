FactoryBot.define do
  factory :reaction do
    sequence(:content) { |n| "test#{n}reaction" }
    association :user
    association :statement
    created_at {Time.zone.now}

    trait :yesterday do
      created_at { 1.day.ago }
    end
  end
end
