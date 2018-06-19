class UserTeam < ApplicationRecord
  belongs_to :user, presence: true
  belongs_to :team, presence: true
end
