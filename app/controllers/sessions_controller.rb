class SessionsController < ApplicationController
  before_action :not_guest_user, only: [:create]

  def new
  end

  def create
  end

  def destroy
  end

end
