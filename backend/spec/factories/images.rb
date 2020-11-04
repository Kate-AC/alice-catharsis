FactoryBot.define do
  factory :image do
    target_type { 0 }
    sequence(:title) { |n| "title#{n}"}
    sequence(:url) { |n| "https://url#{n}"}
    sequence(:thumbnail) { |n| "https://thumbnail#{n}"}
    adjusty { "{\"width\":\"100%\",\"top\":\"0px\",\"left\":\"0px\"}" }
    deleted { 0 }

    trait :r18 do
      target_type { 1 }
    end

    trait :deleted do
      deleted { 1 }
    end
  end
end
