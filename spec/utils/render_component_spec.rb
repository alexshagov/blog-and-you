require 'rails_helper'

RSpec.describe RenderComponent do
  it 'calls the helper to render a view component' do
    application_controller_instance_double = instance_double(ApplicationController)
    render_component_double = double

    allow(ApplicationController).to receive(:new).and_return(application_controller_instance_double)
    allow(application_controller_instance_double).to receive(:helpers).and_return(render_component_double)
    allow(render_component_double).to receive(:render_component)

    described_class.call(component: 'component', locals: { data: '123' })

    expect(render_component_double).to have_received(:render_component).with('component', { data: '123' })
  end
end
