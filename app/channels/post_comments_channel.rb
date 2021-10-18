class PostCommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from stream_identifier if post
  end

  def send_comment(payload)
    form = Posts::CreateComment::Form.new(text: payload["comment"])
    comment = Posts::CreateComment::Action.new(form: form, user: current_user, post: post).call
  end

  private

  def stream_identifier
    "post_#{post.id}_comments"
  end

  def post
    Post.find_by(id: params[:post_id])
  end
end
