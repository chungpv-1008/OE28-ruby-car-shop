class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  private

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "users.logged_in"
    redirect_to login_url
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "users.get_error"
    redirect_to root_url
  end

  def load_posts
    @posts = Post.by_year_of_manufacture(params[:year_of_manufacture_id])
      .by_fuel(params[:fuel_id])
      .by_gearbox(params[:gearbox_id])
      .by_car_type(params[:car_type_id])
      .by_origin(params[:origin_id])
      .by_brand(params[:brand_id])
      .by_car_model(params[:car_model_id])
      .by_color(params[:color_id])
      .by_number_of_seat(params[:number_of_seat_id])
      .by_condition(params[:condition_id])
      .include_car
  end
end
