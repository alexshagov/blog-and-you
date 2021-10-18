module Posts
  module AddCommentReaction
    class ValidationError < StandardError; end

    POSSIBLE_REACTIONS = %w[like smile thumbs-up].freeze

    class Action
      def initialize(user:, comment_id:, reaction_type:, **opts)
        @user = user
        @comment_id = comment_id
        @reaction_type = reaction_type

        @ws_server = opts[:ws_server] || ActionCable.server
      end

      def call
        validate_reaction_type!

        @comment = Post::Comment.find(comment_id)
        comment.reactions.create(user: user, reaction_type: reaction_type)
        broadcast_message!
      end

      private

      def validate_reaction_type!
        raise ValidationError unless reaction_type.in? POSSIBLE_REACTIONS
      end

      def broadcast_message!
        ws_server.broadcast("post_#{comment.post.id}_comments_reactions",
                            { commentId: comment_id, reactionType: reaction_type, value: 1 })
      end

      attr_reader :user, :comment_id, :comment, :reaction_type,
                  :ws_server
    end
  end
end
