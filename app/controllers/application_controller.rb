class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

   protected

   def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:university_id, :name, :website, :twitter, :facebook, :instagram, :code, :plan])
 	devise_parameter_sanitizer.permit(:account_update, keys: [:university_id, :name, :website, :twitter, :facebook, :instagram, :code, :plan])
  end
end
