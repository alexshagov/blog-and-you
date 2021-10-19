require 'rails_helper'

RSpec.describe 'Posts Edit', type: :request do
  describe 'GET /posts/:id' do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user: user) }

    it 'returns http success' do
      get edit_post_path(post.id, as: user)

      expect(response).to have_http_status(:success)
      expect(response.body).to include('Update post')
    end
  end
end
