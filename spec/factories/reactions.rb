FactoryBot.define do
  factory :reaction do
    user { nil }
    reactable { nil }
    reaction_type { "MyString" }
  end
end
