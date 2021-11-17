class Item < ApplicationRecord
  validates :content, presence: true, length: {maximum: 20}
  validates :meaning, presence: true, length: {maximum: 20}
  validates :memo, presence: true, length: {maximum: 50}
  belongs_to :user
end
