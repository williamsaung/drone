class Drone < ApplicationRecord
  belongs_to :user
  has_many :nav_logs
  has_many :missions
end
