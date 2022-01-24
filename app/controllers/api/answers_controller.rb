class Api::AnswersController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :edit, :update]
  before_action :not_guest_user, only: [:index, :edit, :update]

  def index
    @answers = current_user.answers.all_created_at_the_date(params[:created_at])
  end

  def new
    @questions = Question.of_selected_mode(params[:mode_num])
    @question = @questions.randomly_selected(@questions)
    render json: @question
  end

  def create
    @question = Question.find(params[:id])
    @answer = @question.answers.new(answer_params)
    @answer.assign_attributes(user_id: current_user.id)
    if @answer.save
      response_success(:answer, :create)
    end
  end

  def edit
    @answer = current_user.answers.find(params[:id])
    @date = @answer.created_at.to_date
    @question = Question.find_by(id: @answer.question_id)
    @deepl_api_key = Rails.application.credentials.deepl[:api_key]
  end

  def update
    @answer = current_user.answers.find(params[:id])
    @question = Question.find_by(id: @answer.question_id)
    if @answer.update(answer_params)
      response_success(:answer, :update)
    else
      response_bad_request
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end
end
