class CommentPresenter
  attr_reader :comment

  def initialize(comment, **opts)
    @comment = comment
    @cache = opts[:cache] || Cache
  end

  def reaction_sent?(by:, reaction_type:)
    user_reactions = cache.fetch_user_reactions_cache(by, comment.post)
    post_reactions = cache.fetch_post_reactions_cache(comment.post)

    return false if post_reactions.nil? || user_reactions.nil?

    user_reactions.select { is?(_1, reaction_type) }.intersection(
      post_reactions.select { is?(_1, reaction_type) }
    ).present?
  end

  def reactions_count(reaction_type)
    post_reactions = cache.fetch_post_reactions_cache(comment.post)
    return comment.reactions.where(reaction_type: reaction_type, reactable: comment).count if post_reactions.nil?

    post_reactions.select { is?(_1, reaction_type) }.count
  end

  private

  def is?(reaction, reaction_type)
    reaction.reactable_id == comment.id && reaction.reaction_type == reaction_type
  end

  attr_reader :cache
end
