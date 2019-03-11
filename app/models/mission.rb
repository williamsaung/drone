class Mission < ApplicationRecord
  belongs_to :drone
  belongs_to :location


  def self.search(params)
    missions = Mission.where("Location LIKE ? or Name LIKE ?", "%{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
    missions
  end


end
