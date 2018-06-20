class Team < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }
  validates :color, presence: true, color: :true

  has_many :user_teams
  has_many :users, through: :user_teams

  DEFAULT_COLORS = { red: '#ef5b3e', pink: '#ff658b', orange: '#ff9933',
  yellow: '#eec400', blue: '#40bbef', green: '#2fc3a7', black: '#333333' }
end
