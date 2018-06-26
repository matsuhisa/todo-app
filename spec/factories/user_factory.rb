FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "みんなのウェディング#{n}" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password "TEST_PASSWORD"
    password_confirmation "TEST_PASSWORD"

    factory :user_with_tasks do
      transient do
        tasks_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:task, evaluator.tasks_count, user: user)
      end
    end
  end
end
