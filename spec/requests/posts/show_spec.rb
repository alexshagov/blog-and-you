require 'rails_helper'

RSpec.describe 'Posts Show', type: :request do
  describe 'GET /posts/:id' do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user: user) }

    it 'returns http success and renders the post' do
      get post_path(post, as: user)

      expect(response).to have_http_status(:success)
      expect(response.body).to include('All posts')
      expect(response.body).to include(post.title)
      expect(response.body).to include(post.content)
      expect(response.body).to include('No comments')
    end

    context 'when comments present' do
      it 'renders the comments as well' do
        comment1 = FactoryBot.create(:post_comment, post: post, user: user, text: 'comment1')
        comment2 = FactoryBot.create(:post_comment, post: post, user: user, text: 'comment2')

        get post_path(post, as: user)

        expect(response).to have_http_status(:success)
        expect(response.body).to include(comment1.text)
        expect(response.body).to include(comment2.text)
      end
    end
  end
end
