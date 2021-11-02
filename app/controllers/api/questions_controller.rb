class Api::QuestionsController < ApplicationController
  before_action :admined_user

  def index
    @questions = Question.where(mode_num: params[:mode_num])
    render json: @questions
  end

  def show
    @questions = Question.where(mode_num: params[:mode_num])
    @question = @questions.find(@questions.pluck(:id).sample)
    render json: {content: @question.content}
  end

  def new
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

  #before action

end
