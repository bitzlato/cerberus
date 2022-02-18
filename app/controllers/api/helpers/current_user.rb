# frozen_string_literal: true

module API
  module Helpers
    module CurrentUser
      def current_user_info
        @current_user_info ||= request.env['jwt.payload']&.with_indifferent_access
      end

      def current_user_uid
        current_user_info.try(:[], :uid)
      end

      def current_user
        @current_user ||= Barong::User.find_by(uid: current_user_uid)
      end
    end
  end
end
