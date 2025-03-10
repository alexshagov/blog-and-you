require 'rails_helper'

RSpec.describe Posts::CreateComment::Action do
  subject(:action) { described_class.new(form: form, user: user, post: post) }

  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user) }
  let(:form) do
    Posts::CreateComment::Form.new(text: 'comment')
  end

  it 'creates a comment' do
    expect { action.call }.to change { post.comments.count }.by(1)
  end

  context 'when form is invalid' do
    let(:form) do
      Posts::CreateComment::Form.new(text: nil)
    end

    it 'raises a validation error' do
      expect { action.call }.to raise_error Posts::CreateComment::ValidationError
    end
  end

  describe 'broadcasting' do
    subject(:action) do
      described_class.new(form: form,
                          user: user,
                          post: post,
                          ws_server: ws_server_double,
                          component_renderer: component_renderer_double)
    end

    let(:ws_server_double) { double }
    let(:component_renderer_double) { class_double(RenderComponent) }

    it 'broadcasts a message via websocket' do
      allow(ws_server_double).to receive(:broadcast)
      allow(component_renderer_double).to receive(:call)
        .with(component: 'post-comment',
              locals: { comment: instance_of(Post::Comment), user: user }).and_return('data')

      action.call

      expect(ws_server_double).to have_received(:broadcast).with("post_#{post.id}_comments", { comment: 'data' })
    end
  end
end
