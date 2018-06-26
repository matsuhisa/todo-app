FactoryBot.define do
  factory :task do
    title '資料の作成'
    description 'エンジニアミーティング用の資料を作成する'
    association :user
    association :team
    state 'registered'
  end
end
