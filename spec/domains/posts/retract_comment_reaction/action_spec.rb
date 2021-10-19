require 'rails_helper'

RSpec.describe Posts::RetractCommentReaction::Action do
  subject(:action) { described_class.new(user: user, comment_id: comment.id, reaction_type: reaction_type) }

  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user) }
  let(:comment) { FactoryBot.create(:post_comment, post: post, user: user) }
  let(:reaction_type) { 'smile' }

  it 'removes a user reaction from the comment' do
    FactoryBot.create(:reaction, user: user, reactable: comment, reaction_type: reaction_type)

    expect { action.call }.to change { comment.reactions.where(reaction_type: 'smile').count }.by(-1)
  end

  context 'when reaction is not found for a user' do
    it 'does nothing' do
      expect { action.call }.to change { comment.reactions.count }.by(0)
    end
  end

  describe 'broadcasting' do
    subject(:action) do
      described_class.new(user: user,
                          comment_id: comment.id,
                          reaction_type: reaction_type,
                          ws_server: ws_server_double)
    end

    let(:reaction_type) { 'smile' }
    let(:ws_server_double) { double }

    it 'broadcasts a message via websocket' do
      allow(ws_server_double).to receive(:broadcast)

      action.call

      expect(ws_server_double).to have_received(:broadcast)
        .with("post_#{post.id}_comments_reactions",
              { commentId: comment.id,
                reactionType: reaction_type, value: -1 })
    end
  end

  describe 'cache' do
    subject(:action) do
      described_class.new(user: user,
                          comment_id: comment.id,
                          reaction_type: reaction_type,
                          cache: cache_double)
    end

    let(:reaction_type) { 'smile' }
    let(:cache_double) { class_double(Cache) }

    it 'updates reactions cache' do
      allow(cache_double).to receive(:update_user_reactions_cache)
      allow(cache_double).to receive(:update_post_reactions_cache)

      action.call

      expect(cache_double).to have_received(:update_user_reactions_cache).with(user, post)
      expect(cache_double).to have_received(:update_post_reactions_cache).with(post)
    end
  end
end
