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
  end
end
