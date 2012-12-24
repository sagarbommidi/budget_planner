module ApplicationHelper

  def date_in_words(date)
    if date == Date.today
      "Today"
    elsif date == Date.today-1
      "Yesterday"
    else
      date
    end
  end

  def get_active_klass(value)
    "active" if (value.eql?(params[:controller]) || value.eql?(params[:component]))
  end
end
