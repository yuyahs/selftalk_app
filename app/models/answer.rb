class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  validates :content, presence: true, length: {maximum: 255}
  default_scope -> { order(created_at: :desc) }

  scope :created_in_a_week, -> { where(created_at: Time.current.all_week) }
  scope :all_created_at_the_date, -> (params){where(["created_at Like ?", "%#{params}%"])}
  # @answers = current_user.answers.where(["created_at Like ?",
  #   "%#{params[:created_at]}%"])

end
