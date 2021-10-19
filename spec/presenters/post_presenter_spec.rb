require 'rails_helper'

RSpec.describe PostPresenter do
  subject { described_class.new(post) }

  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user) }

  describe '#owned_by?' do
    it 'returns true if owned by a user' do
      expect(subject.owned_by?(user)).to eq true
    end

    it 'returns false if owned by an another user' do
      another_user = FactoryBot.create(:user, email: 'hacker@mail.com')

      expect(subject.owned_by?(another_user)).to eq false
    end
  end
end
