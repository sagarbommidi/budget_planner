class TagsController < ApplicationController

  def show
    @tag = current_user.tags.include_component(params[:component]).find(params[:id])
  end

end
