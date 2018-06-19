class Team < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }
  validates :color, presence: true, color: :true

  has_many :user_teams
  has_many :users, through: :user_teams
end
