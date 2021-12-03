class Api::QuestionsController < ApplicationController
  before_action :admined_user

  #出題文一覧表示機能（管理ユーザー用）
  def index
    @questions1 = Question.where(mode_num: 1) #explain course
    @questions2 = Question.where(mode_num: 2) #reaction course
    @questions3 = Question.where(mode_num: 3) #translate course
  end

  #ランダムな出題を行う機能
  def show
    @questions = Question.get_questions(mode_num: params[:mode_num])
    @question = @questions.find(@questions.pluck(:id).sample)
    render json: {content: @question.content}
  end

  #出題文作成機能（管理ユーザー用）
  def create
    @question = Question.new(question_params)
    if @question.save
      response_success(:question, :create)
    else
      response_bad_request
    end
  end

  #出題文削除機能（管理ユーザー用）
  def destroy
    Question.find(params[:id]).destroy
    response_success(:question, :destroy)
  end

  private

  def question_params
    params.require(:question).permit(:content, :mode_num)
  end

end
