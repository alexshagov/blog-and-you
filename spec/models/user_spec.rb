require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:reactions) }
    it { is_expected.to have_many(:comments).class_name('Post::Comment') }
  end
end
