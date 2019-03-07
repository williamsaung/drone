module Api
  module V1
    class DroneController < ApplicationController
      protect_from_forgery with: :null_session
      respond_to :json
      def index
        respond_with Drone.all
      end
    end
  end
end