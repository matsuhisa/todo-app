FactoryBot.define do
  factory :team do
    sequence(:name) { |n| "TEST_TEAM#{n}" }
    color '#ffffff'
  end
end
