class HomeController < ApplicationController
  helper_method :resource_name, :resource, :devise_mapping, :resource_class
  prepend_before_action :usersignin
  def index
  end
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  def usersignin
    if user_signed_in?
          if current_user.role.user_type == "Admin"
        redirect_to rails_admin_path
      elsif current_user.role.user_type == "Employee"
        redirect_to employees_index_path
      else
        redirect_to clients_index_path
      end
    end
  end
end
