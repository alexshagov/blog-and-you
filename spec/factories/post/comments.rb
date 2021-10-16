FactoryBot.define do
  factory :post_comment, class: 'Post::Comment' do
    user { nil }
    text { "MyString" }
  end
end
