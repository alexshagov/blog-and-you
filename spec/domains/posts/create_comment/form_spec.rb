require 'rails_helper'

RSpec.describe Posts::CreateComment::Form, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:text) }
  end
end
