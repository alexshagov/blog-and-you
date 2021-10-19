require 'rails_helper'

RSpec.describe Posts::Edit::Action do
  subject(:action) { described_class.new(form: form, user: user) }

  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user) }
  let(:form) do
    Posts::Edit::Form.new(title: 'new title', content: 'new content', post: post)
  end

  it 'updates a post' do
    expect { action.call }.to change(post, :title).to('new title').and change(post, :content).to('new content')
  end

  context 'when form is invalid' do
    let(:form) do
      Posts::Edit::Form.new(title: 'title', content: nil, post: post)
    end

    it 'raises a validation error' do
      expect { action.call }.to raise_error Posts::Edit::ValidationError
    end
  end

  context 'when the post belongs to a different user' do
    subject(:action) { described_class.new(form: form, user: second_user) }

    let(:second_user) { FactoryBot.create(:user, email: 'hacker@mail.com') }

    it 'raises an authorizatoin error' do
      expect { action.call }.to raise_error Posts::Edit::AuthorizationError
    end
  end
end
