class User < ApplicationRecord
  include Clearance::User

  has_many :posts, dependent: :destroy
  has_many :comments, class_name: 'Post::Comment', dependent: :destroy
end
