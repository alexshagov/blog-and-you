class PostsController < ApplicationController
  before_action :require_login

  def index
    @posts = Post.includes(:user)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user, :reactions)

    Cache.update_user_reactions_cache(current_user, @post)
    Cache.update_post_reactions_cache(@post)
  end

  def new
    @form = Posts::Create::Form.new
  end

  def create
    @form = Posts::Create::Form.new(create_post_params)
    @action = Posts::Create::Action.new(form: @form, user: current_user)
    begin
      post = @action.call
      redirect_to post
    rescue Posts::Create::ValidationError
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @form = Posts::Edit::Form.new(post: @post)
  end

  def update
    @post = Post.find(params[:id])
    @form = Posts::Edit::Form.new(update_post_params.merge(post: @post))
    @action = Posts::Edit::Action.new(form: @form, user: current_user)
    begin
      @action.call
      redirect_to @form.post
    rescue Posts::Edit::ValidationError
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @action = Posts::Delete::Action.new(post: @post, user: current_user)
    @action.call
    redirect_to posts_path
  end

  private

  def create_post_params
    params.require(:posts_create_form).permit(:title, :content)
  end

  def update_post_params
    params.require(:posts_edit_form).permit(:title, :content)
  end
end
