module UsersHelper

  #学習記録が連続しているか判別するために昨日と今日のanswerを取得する
  #api/users_controllerのshowアクションで使用
  def yesterday_answer
    yesterday = Time.zone.yesterday
    current_user.answers.where(:created_at => yesterday ..  )
  end

  def today_answers
    today = Time.zone.now
    current_user.answers.where(created_at: today.all_day)
  end

end
