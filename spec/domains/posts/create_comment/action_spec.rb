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
end
