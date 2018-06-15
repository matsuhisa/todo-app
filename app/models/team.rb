class Team < ApplicationRecord
  validates :name, presence: true
  validates :color, presence: true
end
