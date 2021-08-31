FactoryBot.define do
  factory :question do
    sequence(:content)  { |n| "test#{n}question" }
  end
end
