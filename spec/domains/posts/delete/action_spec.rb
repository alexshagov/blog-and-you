require 'rails_helper'

RSpec.describe Posts::Delete::Action do
  subject(:action) { described_class.new(post: post, user: user) }

  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user) }

  before do
    user
    post
  end

  it 'deletes a post' do
    expect { action.call }.to change { user.posts.count }.by(-1)
  end

  context 'when the post belongs to a different user' do
    subject(:action) { described_class.new(post: post, user: second_user) }

    let(:second_user) { FactoryBot.create(:user, email: 'hacker@mail.com') }

    it 'raises an authorization error' do
      expect { action.call }.to raise_error Posts::Delete::AuthorizationError
    end
  end
end
