class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_global_search_variable
  
  def set_global_search_variable
   @q = Post.search(params[:q])
  end
   protected

   def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:university_id, :name, :website, :twitter, :facebook, :instagram, :code, :plan, :snapchat, :anon_id, :address, :latitude, :longitude])
 	devise_parameter_sanitizer.permit(:account_update, keys: [:university_id, :name, :website, :twitter, :facebook, :instagram, :code, :plan, :snapchat, :anon_id, :address, :latitude, :longitude])
   end
end
