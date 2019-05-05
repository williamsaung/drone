module Api
  module V1
    class DroneAvailablesController < ApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def available
        @available = DroneAvailable.new
        @available.status = params[:status]
        @available.save
      end
    end
  end
end