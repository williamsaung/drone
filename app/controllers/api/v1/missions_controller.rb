module Api
  module V1
    class MissionsController < ApplicationController
      # TODO
      before_action :authorize_request, except: [:create, :update]
      before_action :find_user, except: %i[create index]
      protect_from_forgery with: :null_session
      respond_to :json
      def index
        respond_with Mission.all
      end

      def update
        respond_to do |format|
          if @mission.update(mission_params)
            format.html { redirect_to @mission, notice: 'Mission was successfully updated.' }
            format.json { render :show, status: :ok, location: @mission }
          else
            format.html { render :edit }
            format.json { render json: @mission.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end
end