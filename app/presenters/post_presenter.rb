class PostPresenter
  attr_reader :post

  def initialize(post)
    @post = post
  end

  def owned_by?(user)
    post.user == user
  end
end
