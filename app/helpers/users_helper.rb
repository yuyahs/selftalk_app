module UsersHelper

  def sequential_days
    yesterday = Time.zone.yesterday
    today = Time.zone.today
    sequential_records = current_user.answers.where(:created_at => yesterday ..  )
    if sequential_records.nil?
      @sequential_days = 0
    else
      @sequential_days = sequential_records.map{|dates| dates.created_at.to_date}.uniq
      @sequential_days = @sequential_days.count
    end
  end

end
