class ComponentCell < Cell::Rails
  helper ApplicationHelper

  def new(args)
    @component = get_new_component(args)
    @user = args[:user]
    render
  end

  def show(args)
    @user = args[:user]
    @component = args[:component]
    render
  end

  private

  def get_new_component(args)
    args[:component].singularize.capitalize.constantize.new
  end
end
