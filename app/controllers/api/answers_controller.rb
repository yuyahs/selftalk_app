class Api::AnswersController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :edit, :update]
  before_action :not_guest_user, only: [:index, :edit, :update]

  def index
    #scopeを使ってmodelに移したが動作しなかったのでこちらに戻した
    @answers = current_user.answers.where(["created_at Like ?",
    "%#{params[:created_at]}%"])
  end

  def new
    @questions = Question.where(mode_num: params[:mode_num])
    #pluckを用いると比較的ランダム性が正確になる
    @question = @questions.find(@questions.pluck(:id).sample)
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
