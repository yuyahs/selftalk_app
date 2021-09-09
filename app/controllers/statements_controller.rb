class StatementsController < ApplicationController
  before_action :admined_user
  
  def index
    @statements = Statement.all
  end

  def new
    @form = Form::StatementCollection.new
  end

  def create
    @form = Form::StatementCollection.new(statement_collection_params)
    if @form.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    Statement.find(params[:id]).destroy
    redirect_to statements_path
  end


  private

  def statement_collection_params
    params.require(:form_statement_collection).permit(statements_attributes: :content)
  end
end
