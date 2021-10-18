require 'rails_helper'

RSpec.describe 'Posts create', type: :request do
  describe 'POST /posts' do
    let(:user) { FactoryBot.create(:user) }
    let(:post_params) do
      {
        posts_create_form: {
          title: 'title',
          content: 'content'
        }
      }
    end

    it 'creates a new post' do
      expect { post posts_path(as: user, params: post_params) }.to change { user.posts.count }.by(1)
    end
  end
end
