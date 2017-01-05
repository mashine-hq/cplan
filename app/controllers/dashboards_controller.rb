class DashboardsController < ApplicationController
  layout 'dashboard'

  def show
    @departments = current_user.departments.enabled
  end

end
