class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, :except => :show

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if !current_user.owner? && !@user.id.eql?(current_user.id)
      redirect_to root_path, alert: t('flash.denied')
    end
  end

  def update
    @user = User.find(params[:id])
    redirect_to users_path, @user.update_attributes(secure_params) ? {notice: t('flash.success')} : {alert: t('flash.update_fail')}
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, notice: t('flash.success_destroy')
  end

  private

  def admin_only
    unless current_user.owner?
      redirect_to root_path, alert: t('flash.denied')
    end
  end

  def secure_params
    params.require(:user).permit(:role)
  end

end
