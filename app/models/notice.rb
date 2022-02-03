class Notice < ApplicationRecord
  validates :title, presence: true, length: {maximum: 255}
  validates :content, presence: true, length: {maximum: 255}

  default_scope -> { order(created_at: :desc) }
end
