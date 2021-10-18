module ApplicationHelper
  def render_component(component_name, locals = {}, &block)
    name = component_name.split("_").first
    render("components/#{name}/#{component_name}", locals, &block)
  end

  def present(object)
    presenter = "#{object.class.name.demodulize}Presenter".constantize
    presenter.new(object)
  end
end
