class PostsController < ApplicationController
  before_action :require_login

  def index
    @posts = Post.includes(:user)
  end
end
