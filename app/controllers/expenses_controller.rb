class ExpensesController < ApplicationController

  def create
    unless params[:tag_names].blank?
      tags = Tag.find_or_create_tags(params[:tag_names], current_user)
      tags.each do |tag|
        current_user.expenses << tag.expenses.build(params[:expense].merge(:user_id => current_user.id))
      end
      current_user.save
    end
    redirect_to :back
  end

  def show
    @expense = current_user.expenses.find(params[:id])
  end
end
