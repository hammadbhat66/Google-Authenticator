class EmployeesController < ApplicationController
		before_action :authenticate_user!
		prepend_before_action :usersignin
  def index
  end
  def usersignin
    if user_signed_in?
      if current_user.role.user_type == "Client"
        redirect_to employees_index_path
      else
      end
    end
  end
end
