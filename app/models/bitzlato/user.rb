# frozen_string_literal: true
module Bitzlato
  class User < Bitzlato::Record
    self.table_name = :user

    has_one :profile, class_name: 'Bitzlato::Profile', foreign_key: :user_id

    # Сортируем для того чтобы у нас всегда отдавался самый первый пользователь
    # потому что в базе могут быть два пользователя с реальными email-ами и разными subject-ами:
    # subject: "google-oauth2|113338472610234582455"
    # subject: "auth0|61268d2e67ea78006a96fca9"
    #
    scope :by_email, ->(email) { where(real_email: email).order(:id) }
  end
end

# == Schema Information
#
# Table name: user
#
#  id                            :integer          not null, primary key
#  subject                       :string(510)      not null
#  nickname                      :string(510)
#  email_verified                :boolean          not null
#  chat_enabled                  :boolean          not null
#  email_auth_enabled            :boolean          not null
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  telegram_id                   :string(256)
#  auth0_id                      :string
#  ref_parent_user_id            :integer
#  referrer                      :integer
#  country                       :string
#  real_email                    :text
#  2fa_enabled                   :boolean          default(FALSE), not null
#  ref_type                      :enum             default("independent"), not null
#  authority_can_make_deal       :boolean          default(TRUE), not null
#  authority_can_make_order      :boolean          default(TRUE), not null
#  authority_can_make_voucher    :boolean          default(TRUE), not null
#  authority_can_make_withdrawal :boolean          default(TRUE), not null
#  authority_is_admin            :boolean          default(FALSE), not null
#  deleted_at                    :datetime
#  password_reset_at             :datetime
#  sys_code                      :string(63)
#
