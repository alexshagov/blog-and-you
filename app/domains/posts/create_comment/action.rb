module Posts
  module CreateComment
    class ValidationError < StandardError; end

    class Action
      def initialize(form:, user:, post:, **opts)
        @form = form
        @user = user
        @post = post

        @ws_server = opts[:ws_server] || ActionCable.server
        @component_renderer = opts[:component_renderer] || RenderComponent
      end

      def call
        raise ValidationError unless form.valid?

        @comment = Post::Comment.create(
          text: form.text,
          user: user,
          post: post
        )

        broadcast_message!

        @comment
      end

      private

      def broadcast_message!
        rendered_comment = component_renderer.call(component: 'post-comment', locals: { comment: comment, user: user })
        ws_server.broadcast("post_#{post.id}_comments", { comment: rendered_comment })
      end

      attr_reader :form, :user, :post, :comment,
                  :ws_server, :component_renderer
    end
  end
end
