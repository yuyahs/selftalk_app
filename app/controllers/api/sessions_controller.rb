class Api::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        # flash[:success] = "ログインしました。"
        # redirect_back_or root_url
      else
        # message = "有効化されていないアカウントです。"
        # message += "認証用メールを確認して有効化リンクをクリックしてください。"
        # flash[:danger] = message
        # redirect_to root_url
        response_unauthorized

      end
    else
      # flash.now[:danger] = "メールアドレスまたはパスワードが違います。"
      # render 'new'
      # render json: @user.errors, status: :unprpcessable_entity
      response_bad_request
    end
  end

  def destroy
    log_out if logged_in?
    # flash[:success] = "ログアウトしました。"
    # redirect_to root_url
  end

end
