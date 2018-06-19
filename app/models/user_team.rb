class UserTeam < ApplicationRecord
  belongs_to :user_id, presence: true
  belongs_to :team_id, presence: true
end
