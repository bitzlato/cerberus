# frozen_string_literal: true

FactoryBot.define do
  factory :applicant do
    barong_uid { rand (999999) }
    batlzato_uid { rand (999999) }

    trait :rejected do
      status { 'rejected' }
    end

    trait :verified do
      status { 'rejected' }
    end

    trait :banned do
      status { 'banned' }
    end

    trait :init do
      status { 'init' }
    end
  end
end