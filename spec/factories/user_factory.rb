FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "みんなのウェディング#{n}" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    sequence(:password) { "TEST_PASSWORD" }
    sequence(:password_confirmation) { "TEST_PASSWORD" }
  end
end
