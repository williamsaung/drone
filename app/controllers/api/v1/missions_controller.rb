module Api
  module V1
    class MissionsController < ApplicationController
      protect_from_forgery with: :null_session
      respond_to :json
      def index
        respond_with Mission.all
      end
    end
  end
end