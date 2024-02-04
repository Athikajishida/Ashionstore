class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone])
    end

    def after_sign_in_path_for(resource)
     admin_index_path
    end

    private 
    def authorize_admin!
        unless current_user && current_user.admin?
          redirect_to root_path, alert: "You are not authorized to access this page."
        end
      end
  end
  