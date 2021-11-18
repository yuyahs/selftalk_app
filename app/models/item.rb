class Item < ApplicationRecord
  validates :content, presence: true, length: {maximum: 50}
  validates :meaning, presence: true, length: {maximum: 50}
  validates :memo, presence: true, length: {maximum: 100}
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
end
