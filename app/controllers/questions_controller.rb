class QuestionsController < ApplicationController
  before_action :admined_user

  def index
    @questions = Question.all
  end

  def new
    @form = Form::QuestionCollection.new
  end

  def create
    @form = Form::QuestionCollection.new(question_collection_params)
    if @form.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    Question.find(params[:id]).destroy
    redirect_to questions_path
  end

  private

  def question_collection_params
    params.require(:form_question_collection).permit(questions_attributes: [:content, :mode_num])
  end

  #before action


end
