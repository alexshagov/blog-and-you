module Posts
  module Delete
    class AuthorizationError < StandardError; end

    class Action
      def initialize(post:, user:)
        @post = post
        @user = user
      end

      def call
        raise AuthorizationError if belongs_to_a_different_user?

        post.destroy
      end

      private

      attr_reader :post, :user

      def belongs_to_a_different_user?
        post.user != user
      end
    end
  end
end
