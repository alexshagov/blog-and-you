require 'rails_helper'

RSpec.describe Posts::Create::Action do
  subject(:action) { described_class.new(form: form, user: user) }

  let(:user) { FactoryBot.create(:user) }
  let(:form) do
    Posts::Create::Form.new(title: 'title', content: 'content')
  end

  it 'creates a post' do
    expect { action.call }.to change { user.posts.count }.by(1)
  end

  context 'when form is invalid' do
    let(:form) do
      Posts::Create::Form.new(title: 'title', content: nil)
    end

    it 'raises a validation error' do
      expect { action.call }.to raise_error Posts::Create::ValidationError
    end
  end
end
