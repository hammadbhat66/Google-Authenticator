class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role_id])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
  end
  	
  	def after_sign_in_path_for(resource)
  		if current_user.role.user_type == "Admin"
  		return rails_admin_url
  		elsif current_user.role.user_type == "Employee"
  		return employees_index_url
  		else
  		return clients_index_url
  		end
  	end
  	def after_sign_out_path_for(resource)
      root_path
    end
end
