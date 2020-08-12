class UsersController < ApplicationController
  before_action :load_user, :correct_user, only: %i(show edit update)
  before_action :logged_in_user, except: %i(show new create)

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".new.sign_up_success"
      redirect_to @user
    else
      flash[:danger] = t ".new.sign_up_fail"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end
end
