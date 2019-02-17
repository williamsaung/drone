module Api
  module V1
    class NavLogsController < ApplicationController
      respond_to :json

      def index
        respond_with NavLog.all
      end

    end
  end
end