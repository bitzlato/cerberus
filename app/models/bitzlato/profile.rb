# frozen_string_literal: true

module Bitzlato
  class Bitzlato::Profile < Bitzlato::Record
    self.table_name = :user_profile
    belongs_to :bitzlato_user, class_name: 'Bitzlato::User', foreign_key: :user_id
  end
end

# == Schema Information
#
# Table name: user_profile
#
#  id                           :integer          not null, primary key
#  lang                         :string(2)        not null
#  user_id                      :integer          not null
#  currency                     :string(5)        not null
#  cryptocurrency               :string(256)      not null
#  start_of_use_date            :datetime
#  rating                       :decimal(, )      not null
#  lastactivity                 :datetime         not null
#  blocked_by_admin             :boolean          default(FALSE), not null
#  old_trade_status             :enum             default("pause"), not null
#  cancreateadvert_status       :boolean
#  cancreateadvert_reason       :enum
#  verified                     :boolean          default(FALSE), not null
#  about_user                   :text             default("")
#  telegram_name                :string
#  user_info                    :text
#  licensing_agreement_accepted :boolean          default(FALSE), not null
#  greeting                     :text
#  safe_mode_enabled            :boolean          default(TRUE), not null
#  pass_safety_wizard           :boolean          default(FALSE), not null
#  suspicious                   :boolean          default(FALSE), not null
#  copilka                      :decimal(, )
#  merged                       :boolean          default(FALSE), not null
#  public_name                  :string(28)
#  lang_web                     :string(2)
#  verification_date            :datetime
#  accept_marketing_emails      :boolean          default(TRUE), not null
#  generated_name               :string(28)       not null
#  phone                        :string(20)
#  is_muted                     :boolean          default(FALSE), not null
#  timezone                     :string(100)
#  pass_merge_wizard            :boolean          default(FALSE), not null
#  safetyIndex_modifier         :integer          default(0), not null
#  avatar                       :string(40)
#  self_frozen                  :boolean          default(FALSE), not null
#
