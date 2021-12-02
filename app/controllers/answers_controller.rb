class AnswersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit]
  before_action :not_guest_user, only: [:index, :edit]

  def index
  end

  def new
  end

  def edit
  end
end

