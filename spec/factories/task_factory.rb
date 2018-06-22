FactoryBot.define do
  factory :task do
    title '資料の作成'
    description 'エンジニアミーティング用の資料を作成する'
    user_id 1
    team_id 1
    state 'registered'
  end
end
