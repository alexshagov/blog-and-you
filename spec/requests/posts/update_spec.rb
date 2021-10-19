require 'rails_helper'

RSpec.describe 'Posts Update', type: :request do
  describe 'PATCH /posts/:id' do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user: user) }
    let(:post_params) do
      {
        posts_edit_form: {
          title: 'new title',
          content: post.content
        }
      }
    end

    it 'updates a post' do
      expect { patch post_path(post.id, as: user, params: post_params) }
        .to change { post.reload.title }.to('new title')
    end
  end
end
