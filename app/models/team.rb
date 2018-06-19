class Team < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }
  validates :color, presence: true
end
