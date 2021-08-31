FactoryBot.define do
  factory :user do
    name {"Example"}
    sequence(:email) { |n| "tester#{n}@example.com" }
    password {"password"}
    password_confirmation {"password"}
    activated {true}
    activated_at {Time.zone.now}

    trait :no_activated do
      activated { false }
      activated_at { nil }
    end
    trait :admin do
      admin { true }
    end
  end
end
