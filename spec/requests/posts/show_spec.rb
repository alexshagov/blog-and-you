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
    end
  end
end
