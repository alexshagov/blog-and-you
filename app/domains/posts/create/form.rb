module Posts
  module Create
    class Form
      include ActiveModel::Model

      attr_accessor :title, :content

      validates :title, :content, presence: true
    end
  end
end
