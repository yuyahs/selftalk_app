class Item < ApplicationRecord
  validates :content, presence: true, length: {maximum: 100},
  belongs_to :user
end
