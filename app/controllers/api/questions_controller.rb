class Api::QuestionsController < ApplicationController
  # before_action :admined_user

  def index
    @questions = Question.where(mode_num: params[:mode_num])
    @questions = Kaminari.paginate_array(@questions).page(params[:page]).per(5)
  end

  def show
    @questions = Question.where(mode_num: params[:mode_num])
    @question = @questions.find(@questions.pluck(:id).sample)
    # render 'show', formats: 'json', handlers: 'jbuilder'
    render json: {content: @question.content}
  end

  def new
    @form = Form::QuestionCollection.new
  end

  def create
    @form = Form::QuestionCollection.new(question_collection_params)
    if @form.save
      flash[:success] = "問題を作成しました。"
      redirect_to root_url
    else
      flash.now[:danger] = "問題の作成に失敗しました。"
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
