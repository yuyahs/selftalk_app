class Form::QuestionCollection < Form::Base
  FORM_COUNT = 10 #ここで、作成したい登録フォームの数を指定
  attr_accessor :questions

  def initialize(attributes = {})
    super attributes
    self.questions = FORM_COUNT.times.map { Question.new() } unless self.questions.present?
  end

  def questions_attributes=(attributes)
    self.questions = attributes.map { |_, v| Question.new(v) }
  end


  def save
    # 実際にやりたいことはこれだけ
    # self.memos.map(&:save!)

    # 複数件全て保存できた場合のみ実行したいので、transactionを使用する
    Question.transaction do
      self.questions.map(&:save!)
    end
      return true
    rescue => e
      return false
  end
end
