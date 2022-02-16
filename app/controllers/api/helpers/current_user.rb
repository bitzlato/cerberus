# frozen_string_literal: true

module API
  module Helpers
    module CurrentUser
      def current_user_info
        @current_user_info ||= request.env['jwt.payload']&.with_indifferent_access
      end

      def current_user_uid
        current_user_info[:uid]
      end
    end
  end
end
