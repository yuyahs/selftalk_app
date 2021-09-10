class Form::StatementCollection < Form::Base
  FORM_COUNT = 10
  attr_accessor :statements

  def initialize(attributes = {})
    super attributes
    self.statements = FORM_COUNT.times.map { Statement.new() } unless self.statements.present?
  end

  # 上でsuper attributesとしているので必要
  def statements_attributes=(attributes)
    self.statements = attributes.map { |_, v| Statement.new(v) }
  end

  def save
    # 実際にやりたいことはこれだけ
    # self.memos.map(&:save!)

    # 複数件全て保存できた場合のみ実行したいので、transactionを使用する
    Statement.transaction do
      self.statements.map(&:save!)
    end
      return true
    rescue => e
      return false
  end
end