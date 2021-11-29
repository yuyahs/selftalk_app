module TestHelper
  def is_logged_in?
    !session[:user_id].nil?
  end


  def log_in_as(user, remember_me: '1')
    post '/api/login', params: { session: {
      email: user.email,
      password: user.password,
      remember_me: remember_me,
    } }
  end

  def guest_login
    post '/api/guest_sign_in'
  end

  def log_in(user)
    visit api_login_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end
end

RSpec.configure do |config|
  config.include TestHelper
end
