FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "みんなのウェディング#{n}" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password "TEST_PASSWORD"
    password_confirmation "TEST_PASSWORD"

    trait :with_team_and_task do
      after(:create) do |user, _|
        team = create(:team, users: [user])
        task = create(:task, user: user, team: team)
      end
    end
  end
end
