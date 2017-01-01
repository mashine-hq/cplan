class VisitorsController < ApplicationController
  #skip_before_action :authenticate_user!
  layout 'dashboard'

  def index
    if current_user
      @departments = current_user.departments
    else
      redirect_to new_user_session_path
    end
  end

end
