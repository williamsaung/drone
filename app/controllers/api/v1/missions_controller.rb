module Api
  module V1
    class MissionsController < ApplicationController
      before_action :authorize_request, except: :create
      before_action :find_user, except: %i[create index]
      protect_from_forgery with: :null_session
      respond_to :json
      def index
        respond_with Mission.all
      end
    end
  end
end