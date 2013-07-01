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

  def get_tag_name(component)
    tag = component.tag
    tag.nil? ? nil : tag.name
  end

  def get_button_text(component)
    component.new_record? ? "Add #{component.class}" : "Update #{component.class}"
  end

  def main_container_class
    devise_controller? ? "" : "body-container" 
  end

end
