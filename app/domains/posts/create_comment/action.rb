module Posts
  module CreateComment
    class ValidationError < StandardError; end

    class Action
      def initialize(form:, user:, post:)
        @form = form
        @user = user
        @post = post
      end

      def call
        raise ValidationError unless form.valid?

        Post::Comment.create(
          text: form.text,
          user: user,
          post: post
        )
      end

      private

      attr_reader :form, :user, :post
    end
  end
end
