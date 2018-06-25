FactoryBot.define do
  factory :task do
    title '資料の作成'
    description 'エンジニアミーティング用の資料を作成する'
    user_id 1
    team_id 1
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
