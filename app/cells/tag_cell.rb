class TagCell < Cell::Rails
  helper ApplicationHelper

  def index(args)
    @user = args[:user]
    @tags = @user.sorted_tags(args[:component])
    @get_component = args[:component]
    render
  end

  def show(args)
    @user = args[:user]
    @tag = args[:tag]
    @components = @tag.send("sorted_#{args[:component]}")
    @get_component = args[:component].singularize
    @components_count = @tag.send(args[:component]).count
    render
  end

end
