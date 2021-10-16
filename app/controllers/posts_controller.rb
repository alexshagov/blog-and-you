class PostsController < ApplicationController
  before_action :require_login

  def index
    @posts = Post.includes(:user)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
  end
end
