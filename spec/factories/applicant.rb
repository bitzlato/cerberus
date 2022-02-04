# frozen_string_literal: true

FactoryBot.define do
  factory :applicant do
    user_uid { rand (999999) }
    applicant_id { rand(999999) }
    inspection_id { rand(999999) }

    trait :rejected do
      review_answer { 'RED' }
      review_reject_type { 'RETRY' }
    end

    trait :verified do
      review_answer { 'GREEN' }
    end

    trait :banned do
      review_answer { 'RED' }
      review_reject_type { 'FINAL' }
    end

    trait :init do
      review_status { 'init' }
    end
  end
end