class AnswersController < ApplicationController
  def new
    @question = Question.find(rand(1..3))
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
    @answer = current_user.answers.find(1)
  end

  def update
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end
end

