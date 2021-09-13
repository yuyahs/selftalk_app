FactoryBot.define do
  factory :question do
    sequence(:content)  { |n| "test#{n}question" }
    mode_num {1}

    trait :mode_2 do
      mode_num {2}
    end
  end
end
