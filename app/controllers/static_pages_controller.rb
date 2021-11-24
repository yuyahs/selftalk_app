class StaticPagesController < ApplicationController

  include SessionsHelper

  def home
  end

  def about
  end

  def contact
  end

  def policy
  end

  #ゲストログイン
  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "ゲストユーザー"
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
