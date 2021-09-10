FactoryBot.define do
  factory :statement do
    sequence(:content)  { |n| "test#{n}statement" }
  end
end
