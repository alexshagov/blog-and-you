class CommentPresenter
  attr_reader :comment

  def initialize(comment)
    @comment = comment
  end

  def reaction_sent?(by:, reaction_type:)
    Reaction.exists?(reactable: comment, user: by, reaction_type: reaction_type)
  end

  def reactions_count(reaction_type)
    comment.reactions.where(reaction_type: reaction_type).count
  end
end
