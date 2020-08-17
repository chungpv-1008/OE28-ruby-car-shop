class PostsController < ApplicationController
  before_action :logged_in_user, only: %i(new create destroy)
  before_action :load_posts, only: :index
  before_action :load_post, only: %i(show update edit)
  before_action :correct_user, only: %i(update edit destroy)

  def index; end

  def show
    @favorite_list_exists = FavoriteList.by_user_id(current_user)
      .by_post_id(@post.id).present?
  end

  def new
    @post = Post.new
    @post.build_car
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      flash[:success] = t ".create_success"
      redirect_to @post
    else
      flash[:danger] = t ".create_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @post.update post_params
      flash[:success] = t ".update_success"
      redirect_to @post
    else
      flash[:danger] = t ".update_fail"
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_back_or @post.user
  end

  private

  def post_params
    params.require(:post).permit Post::POST_PARAMS
  end

  def load_post
    @post = Post.find_by id: params[:id]
    return if @post

    flash[:danger] = t "posts.get_error"
    redirect_to car_list_path
  end

  def correct_user
    @post = current_user.posts.find_by id: params[:id]
    return if @post

    flash[:danger] = t "posts.not_found_post"
    redirect_to car_list_path
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
      .page(params[:page]).per Settings.page
  end
end
