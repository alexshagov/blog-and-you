module Posts
  module RetractCommentReaction
    class Action
      def initialize(user:, comment_id:, reaction_type:, **opts)
        @user = user
        @comment_id = comment_id
        @reaction_type = reaction_type

        @ws_server = opts[:ws_server] || ActionCable.server
      end

      def call
        @comment = Post::Comment.find(comment_id)
        reaction = comment.reactions.find_by(user: user, reaction_type: reaction_type)
        reaction.destroy if reaction.present?

        broadcast_message!
      end

      private

      def broadcast_message!
        ws_server.broadcast("post_#{comment.post.id}_comments_reactions",
                            { commentId: comment_id, reactionType: reaction_type, value: -1 })
      end

      attr_reader :user, :comment_id, :comment, :reaction_type,
                  :ws_server
    end
  end
end
