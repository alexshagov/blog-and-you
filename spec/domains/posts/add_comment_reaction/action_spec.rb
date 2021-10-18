require 'rails_helper'

RSpec.describe Posts::AddCommentReaction::Action do
  subject(:action) { described_class.new(user: user, comment_id: comment.id, reaction_type: reaction_type) }

  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user) }
  let(:comment) { FactoryBot.create(:post_comment, post: post, user: user) }

  %w[like smile thumbs-up].each do |reaction|
    context "when reaction type is #{reaction}" do
      let(:reaction_type) { reaction }

      it 'creates a comment reaction' do
        expect { action.call }.to change { comment.reactions.where(reaction_type: reaction_type).count }.by(1)
      end
    end
  end

  context 'when reaction type is unsopported' do
    let(:reaction_type) { 'lol' }

    it 'raises a validation error' do
      expect { action.call }.to raise_error Posts::AddCommentReaction::ValidationError
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
                reactionType: reaction_type, value: 1 })
    end
  end
end
