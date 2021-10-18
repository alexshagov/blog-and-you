class PostsController < ApplicationController
  before_action :require_login

  def index
    @posts = Post.includes(:user)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user, :reactions)
  end

  def new
    @form = Posts::Create::Form.new
  end

  def create
    @form = Posts::Create::Form.new(post_params)
    @action = Posts::Create::Action.new(form: @form, user: current_user)
    begin
      post = @action.call
      redirect_to post
    rescue Posts::Create::ValidationError
      render :new
    end
  end

  private

  def post_params
    params.require(:posts_create_form).permit(:title, :content)
  end
end
