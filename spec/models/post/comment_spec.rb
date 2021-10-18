require 'rails_helper'

RSpec.describe Post::Comment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
    it { is_expected.to have_many(:reactions) }
  end
end
