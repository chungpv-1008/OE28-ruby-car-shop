class AdminsController < ApplicationController
  include SessionsHelper
  layout "admins"
  before_action :require_admin

  def require_admin
    return if current_user&.admin?

    flash[:danger] = t "admins.not_admin"
    redirect_to root_path
  end
end
