require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /' do
    let(:user) { FactoryBot.create(:user) }

    it 'returns http success' do
      get root_path as: user
      expect(response).to have_http_status(:success)
    end

    it 'renders signed in user message' do
      get root_path as: user
      expect(response.body).to include("Signed in as: #{user.email}")
    end

    it 'renders posts' do
      post1 = FactoryBot.create(:post, user: user)
      post2 = FactoryBot.create(:post, user: user)

      get root_path as: user
      expect(response.body).to include(post1.title.to_s)
      expect(response.body).to include(post2.title.to_s)
    end
  end
end
