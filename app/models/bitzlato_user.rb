# frozen_string_literal: true

class BitzlatoUser < BitzlatoRecord
  self.table_name = :user

  has_one :profile, class_name: 'BitzlatoProfile', foreign_key: :user_id

  # Сортируем для того чтобы у нас всегда отдавался самый первый пользователь
  # потому что в базе могут быть два пользователя с реальными email-ами и разными subject-ами:
  # subject: "google-oauth2|113338472610234582455"
  # subject: "auth0|61268d2e67ea78006a96fca9"
  #
  scope :by_email, ->(email) { where(real_email: email).order(:id) }
end