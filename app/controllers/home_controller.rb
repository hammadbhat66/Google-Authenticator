class HomeController < ApplicationController
  helper_method :resource_name, :resource, :devise_mapping, :resource_class
  prepend_before_action :usersignin
  skip_before_action :verify_authenticity_token, :only => [:check_otp_required]

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
  
  def check_otp_required
    User.all.each do |user|
      if user.email == params[:email]
        if user.otp_required_for_login
          @otp_required = true
        end
      end
    end 
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
