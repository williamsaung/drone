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

      def users_mission
        @user = User.find(params[:id])
        @missions = Mission.where(:user => @user)
        respond_with @missions
      end

      def create
        @mission = Mission.new(mission_params)
        if @mission.save
          render json: @mission, status: :created
        else
          render json: { errors: @mission.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      def update
        @mission = Mission.find(params[:id])
        @mission.update(mission_params)
      end

      def mission_params
        params.permit(:status, :name, :location_id, :weight, :drone_id, :user_id)
      end
    end
  end
end