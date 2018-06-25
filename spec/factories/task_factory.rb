FactoryBot.define do
  factory :task do
    title '資料の作成'
    description 'エンジニアミーティング用の資料を作成する'
    association :user
    association :team
    state 'registered'

    trait :with_user_and_team do
      before(:create) do |task, _|
        user = create(:user)
        team = create(:team, users: [user])
        task.user = user
        task.team = team
      end
    end
  end
end
