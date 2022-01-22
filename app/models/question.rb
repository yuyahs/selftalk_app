class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  validates :content, presence: true, length: {maximum: 255}
  validates :mode_num, presence: true

  scope :of_selected_mode, -> (params){where(mode_num: params)}
  #pluckを用いると比較的ランダム性が正確になる
  scope :randomly_selected, -> (questions){find(questions.pluck(:id).sample)}
end
