module Posts
  module CreateComment
    class Form
      include ActiveModel::Model

      attr_accessor :text

      validates :text, presence: true
    end
  end
end
