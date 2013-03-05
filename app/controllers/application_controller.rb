class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource
  before_filter :authenticate_user!

  def after_sign_in_path_for(resource_or_scope)
    user_incomes_path(resource_or_scope)
  end

  def layout_by_resource
    if devise_controller?
      "home"
    else
      "application"
    end
  end

end
