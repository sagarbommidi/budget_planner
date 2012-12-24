class TimelineCell < Cell::Rails
  helper ApplicationHelper

  def index(args)
    @user = args[:user]
    @tags = @user.tags.include_component(args[:component])
    @components = @user.send("sorted_#{args[:component]}")
    @get_component = args[:component].singularize
    render
  end

end
