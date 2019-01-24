class Mission < ApplicationRecord
  belongs_to :drone
  belongs_to :location
end
