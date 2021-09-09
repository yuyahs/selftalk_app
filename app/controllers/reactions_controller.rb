class ReactionsController < ApplicationController

  def index
    @reactions = current_user.reactions.where(["created_at Like ?", "%#{params[:created_at]}%"])
    @statesment = @reactions.map{|reaction| Reaction.find_by(id: reaction.statement_id)}.uniq
    @reactions = Kaminari.paginate_array(@reactions).page(params[:page]).per(5)
  end

  def new
    @statement = Statement.where( 'id >= ?', rand(Statement.first.id..Statement.last.id) ).first
    @reaction = @statement.reactions.new
  end

  def create
    @statement = Statement.find(params[:id])
    @reaction = @statement.reactions.new(reaction_params)
    @reaction.assign_attributes(user_id: current_user.id)
    if @reaction.save
      redirect_to new_reaction_path
    else
      redirect_to new_reaction_path
    end
  end

  def edit
    @reaction = current_user.reactions.find(params[:id])
    @statement = Statement.find_by(id: @reaction.statement_id)
  end

  def update
    @reaction = current_user.reactions.find(params[:id])
    @statement = Statement.find_by(id: @reaction.statement_id)
    if @reaction.update(reaction_params)
      flash.now[:success] = "回答を保存しました。"
      render 'edit'
    else
      flash.now[:danger] = "回答を保存できませんでした。"
      render 'edit'
    end
  end

  private

  def reaction_params
    params.require(:reaction).permit(:content)
  end
end
