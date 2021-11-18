FactoryBot.define do
  factory :item do
    content { "MyString" }
    meaning {"文字列"}
    memo {"test"}
    association :user
  end
end
