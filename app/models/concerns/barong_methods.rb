module BarongMethods
  extend ActiveSupport::Concern
  included do

    def barong_user
      @barong_user ||= Barong::User.find_by_uid(barong_uid)
    end

  end
end
