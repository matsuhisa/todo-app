class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 10000 }
  validates :state, presence: true

  has_one :user_id
  has_one :team_id

  enum state: { registered: 0, assigned: 1, completed: 2 }
end
