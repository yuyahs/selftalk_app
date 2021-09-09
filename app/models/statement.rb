class Statement < ApplicationRecord
  has_many :reactions, dependent: :destroy
  validates :content, presence: true, length: {maximum: 255}
end
