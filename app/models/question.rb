class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  validates :content, presence: true, length: {maximum: 255}
  validates :mode_num, presence: true

  scope :get_questions, -> (params){where(params)}
end
