module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      reject_unauthorized_connection unless env[:clearance].signed_in?

      self.current_user = env[:clearance].current_user
    end
  end
end
