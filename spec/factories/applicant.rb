# frozen_string_literal: true

FactoryBot.define do
  factory :applicant do
    user_uid { rand (999999) }
    applicant_id { rand(999999) }
  end
end