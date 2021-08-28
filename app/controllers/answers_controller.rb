class AnswersController < ApplicationController

  def index
    @answers = current_user.answers.where(["created_at Like ?", "%#{params[:created_at]}%"])
    @questions = @answers.map{|answer| Question.find_by(id: answer.question_id)}.uniq
  end

  def new
    @question = Question.where( 'id >= ?', rand(Question.first.id..Question.last.id) ).first
    @answer = @question.answers.new
  end

  def create
    @question = Question.find(params[:id])
    @answer = @question.answers.new(answer_params)
    @answer.assign_attributes(user_id: current_user.id)
    if @answer.save!
      redirect_to new_answer_path
    end
  end

  def edit
    @answer = current_user.answers.find(params[:id])
    @question = Question.find_by(id: @answer.question_id)
  end

  def update
    @answer = current_user.answers.find_by(params[:id])
    if @answer.update(answer_params)
      redirect_to answers_path
    else
      render 'edit'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end
end

