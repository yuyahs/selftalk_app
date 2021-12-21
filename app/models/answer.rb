class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  validates :content, presence: true, length: {maximum: 255}
  default_scope -> { order(created_at: :desc) }

  scope :created_in_a_week, -> { where(created_at: Time.current.all_week) }

end
