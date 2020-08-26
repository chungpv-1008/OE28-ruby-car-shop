class PostsController < ApplicationController
  before_action :logged_in_user, only: %i(new create destroy)
  before_action :load_posts, only: :index
  before_action :load_post, only: %i(show update edit)
  before_action :correct_user, only: %i(update edit destroy)
  before_action :check_activated?, only: :show

  def index
    @posts = load_posts.by_activated.by_updated_at
    .page(params[:page]).per Settings.page
  end

  def show
    @favorite_list_exists = FavoriteList.by_user_id(current_user)
    .by_post_id(@post.id).present?
    @favorite_count = FavoriteList.by_post_id(@post.id).size
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

  def update_index
    @posts = params[:sort_id].to_i == 1 ? load_posts.order_by_lower_price : load_posts.order_by_higher_price
    @posts = @posts.by_activated.page(params[:page]).per Settings.page
    respond_to :js
  end

  private

  def post_params
    params.require(:post).permit Post::POST_PARAMS
  end

  def load_post
    @post = Post.find_by id: params[:id]
    return if @post

    flash[:danger] = t "posts.not_found_post"
    redirect_to car_list_path
  end

  def correct_user
    @post = current_user.posts.find_by id: params[:id]
    return if @post

    flash[:danger] = t "posts.not_found_post"
    redirect_to car_list_path
  end

  def check_activated?
    @post = Post.by_activated.find_by(id: params[:id]) ||
      current_user.posts.find_by(id: params[:id])
    return if @post

    flash[:danger] = t "posts.not_found_post"
    redirect_to car_list_path
  end
end
