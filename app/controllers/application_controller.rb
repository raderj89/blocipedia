class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end 

  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to root_url, alert: exception.message
  end

  # def after_sign_up_path_for(resource)
  #   users_path
  # end
end
