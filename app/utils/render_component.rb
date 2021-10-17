class RenderComponent
  class << self
    def call(component:, locals:)
      ApplicationController.new.helpers.render_component(component, locals)
    end
  end
end
