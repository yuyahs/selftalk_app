class Api::QuestionsController < ApplicationController
  include UsersHelper
  before_action :admined_user, only: [:index, :create, :destroy]

  def index
    @questions1 = Question.of_selected_mode(1) #explain course
    @questions2 = Question.of_selected_mode(2) #reaction course
    @questions3 = Question.of_selected_mode(3) #translate course
  end

  def new
    # questionとは関係ないコードだが単に@today_answersをCourse.vueで参照したいだけ
    #他のコントローラーのアクションでは余計なDB通信が発生したりするため余っていたこれを利用
    @today_answers = today_answers.count
    render json: @today_answers
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      response_success(:question, :create)
    else
      response_bad_request
    end
  end

  def destroy
    Question.find(params[:id]).destroy
    response_success(:question, :destroy)
  end

  private

  def question_params
    params.require(:question).permit(:content, :mode_num)
  end

end
