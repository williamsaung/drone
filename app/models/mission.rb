class Mission < ApplicationRecord
  belongs_to :drone
  belongs_to :location
  belongs_to :user
  has_many :uptimes
  after_update :save_endtime

  def save_endtime

      @finduptime = Uptime.last
      @finduptime.end_time = Time.now
      @finduptime.save

  end

  def self.search(params)
    missions = Mission.where("Location LIKE ? or Name LIKE ?", "%{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
    missions
  end



end
