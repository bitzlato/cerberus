# frozen_string_literal: true

FactoryBot.define do
  factory :applicant do
    barong_uid { rand (999999) }
    bitzlato_id { rand (999999) }
    sumsub_applicant_id { rand (999999) }

    trait :rejected do
      status { 'rejected' }
    end

    trait :verified do
      status { 'verified' }
    end

    trait :banned do
      status { 'banned' }
    end

    trait :init do
      status { 'init' }
    end
  end
end