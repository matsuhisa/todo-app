class Task < ApplicationRecord
validates :title, presence: true, length: { maximum: 100 }
validates :description, presence: true, length: { maximum: 300 }
validates :state, presence: true

has_one :user_id
has_one :team_id

enum state: { unfixed: 0, doing: 1, done: 2 }
end
