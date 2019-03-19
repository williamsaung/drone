module Api
  module V1
    class MissionsController < ApplicationController
      # TODO
      before_action :authorize_request, except: [:create, :update]
      protect_from_forgery with: :null_session
      respond_to :json
      def index
        respond_with Mission.all
      end

      def update
        @mission = Mission.find(params[:id])
        @mission.update(mission_params)
      end

      def mission_params
        params.permit(:status)
      end
    end
  end
end