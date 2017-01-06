class DashboardsController < ApplicationController
  layout 'dashboard'

  def show
    @products = current_user.products
    @departments = current_user.departments.enabled
  end

end
