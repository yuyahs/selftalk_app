module UsersHelper

  def yesterday_answer
    yesterday = Time.zone.yesterday
    yesterday_answer = current_user.answers.where(:created_at => yesterday ..  )
  end

  def today_answers
    today = Time.zone.now
    today_answers = current_user.answers.where(created_at: today.all_day)
  end

end
