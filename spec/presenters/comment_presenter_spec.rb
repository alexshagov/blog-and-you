require 'rails_helper'

RSpec.describe CommentPresenter do
  subject { described_class.new(comment) }

  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user) }
  let(:comment) { FactoryBot.create(:post_comment, user: user, post: post) }

  describe '#reaction_sent?' do
    it 'returns true if a reaction has been create by a user' do
      FactoryBot.create(:reaction, reactable: comment, reaction_type: 'smile', user: user)

      expect(subject.reaction_sent?(by: user, reaction_type: 'smile')).to eq true
    end

    it 'returns false if a reaction has not been create by a user' do
      FactoryBot.create(:reaction, reactable: comment, reaction_type: 'smile', user: user)

      expect(subject.reaction_sent?(by: user, reaction_type: 'like')).to eq false
    end
  end

  describe '#reactions_count' do
    it 'returns reactions count' do
      FactoryBot.create(:reaction, reactable: comment, reaction_type: 'smile', user: user)
      FactoryBot.create(:reaction, reactable: comment, reaction_type: 'like', user: user)

      expect(subject.reactions_count('like')).to eq 1
    end
  end
end
