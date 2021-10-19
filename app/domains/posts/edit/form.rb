module Posts
  module Edit
    class Form < Posts::Create::Form
      attr_accessor :post

      validates :post, presence: true
    end
  end
end
