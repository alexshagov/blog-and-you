class PostCommentsReactionsChannel < ApplicationCable::Channel
  def subscribed
    stream_from stream_identifier if post
  end

  def add_reaction(payload)
    Posts::AddCommentReaction::Action.new(user: current_user,
      comment_id: payload['commentId'],
      reaction_type: payload['reactionType']).call
  end

  def retract_reaction(payload)
    Posts::RetractCommentReaction::Action.new(user: current_user,
      comment_id: payload['commentId'],
      reaction_type: payload['reactionType']).call
  end

  private

  def stream_identifier
    "post_#{post.id}_comments_reactions"
  end

  def post
    Post.find_by(id: params[:post_id])
  end
end
