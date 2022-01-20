module UsersHelper

  def yesterday_answer
    yesterday = Time.zone.yesterday
    current_user.answers.where(:created_at => yesterday ..  )
  end

  def today_answers
    today = Time.zone.now
    current_user.answers.where(created_at: today.all_day)
  end

end
