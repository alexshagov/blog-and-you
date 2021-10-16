module Posts
  module Create
    class ValidationError < StandardError; end

    class Action
      def initialize(form:, user:)
        @form = form
        @user = user
      end

      def call
        raise ValidationError unless form.valid?

        Post.create(
          title: form.title,
          content: form.content,
          user: user
        )
      end

      private

      attr_reader :form, :user
    end
  end
end
