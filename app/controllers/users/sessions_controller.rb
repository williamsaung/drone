# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout false
  # before_action :configure_sign_in_params, only: [:create]
  def new
    # render layout: false
  end


end
