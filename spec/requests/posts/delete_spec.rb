require 'rails_helper'

RSpec.describe 'Posts Delete', type: :request do
  describe 'DELETE /posts/:id' do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user: user) }

    before do
      user
      post
    end

    it 'deletes a post' do
      expect { delete post_path(post.id, as: user) }
        .to change { user.posts.count }.by(-1)
    end
  end
end
