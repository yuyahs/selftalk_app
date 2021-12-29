class Api::QuestionsController < ApplicationController
  before_action :admined_user, only: [:index, :create, :destroy]

  def index
    @questions1 = Question.where(mode_num: 1) #explain course
    @questions2 = Question.where(mode_num: 2) #reaction course
    @questions3 = Question.where(mode_num: 3) #translate course
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
