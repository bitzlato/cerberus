module P2PMethods
  extend ActiveSupport::Concern
  included do

    def p2p_user
      @p2p_user ||= BitzlatoUser.find(user_uid)
    end

  end
end