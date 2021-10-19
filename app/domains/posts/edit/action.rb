module Posts
  module Edit
    class ValidationError < StandardError; end

    class AuthorizationError < StandardError; end

    class Action
      def initialize(form:, user:)
        @form = form
        @user = user
      end

      def call
        raise AuthorizationError if belongs_to_a_different_user?
        raise ValidationError unless form.valid?

        form.post.update(
          title: form.title,
          content: form.content
        )
      end

      private

      attr_reader :form, :user

      def belongs_to_a_different_user?
        form.post.user != user
      end
    end
  end
end
