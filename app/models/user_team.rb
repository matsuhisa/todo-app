class UserTeam < ApplicationRecord
  has_one :user_id, presence: true
  has_one :team_id, presence: true
end
