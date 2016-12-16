class VisitorsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    unless current_user
      redirect_to new_user_session_path
    end
  end

end
