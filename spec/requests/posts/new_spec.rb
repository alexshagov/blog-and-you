require 'rails_helper'

RSpec.describe 'Posts New', type: :request do
  describe 'GET /posts/new' do
    let(:user) { FactoryBot.create(:user) }

    it 'returns http success' do
      get new_post_path(as: user)

      expect(response).to have_http_status(:success)
      expect(response.body).to include('Create post')
    end
  end
end
