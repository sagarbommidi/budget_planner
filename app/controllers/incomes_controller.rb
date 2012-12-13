class IncomesController < ApplicationController

  def index
    @income = Income.new
  end

  def create
    unless params[:tag_names].blank?
      tags = Tag.find_or_create_tags(params[:tag_names], current_user)
      tags.each do |tag|
        current_user.incomes << tag.incomes.build(params[:income].merge(:user_id => current_user.id))
      end
      current_user.save
    end
    redirect_to :back
  end
end
