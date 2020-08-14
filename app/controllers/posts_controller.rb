class PostsController < ApplicationController
  before_action :load_post, only: %i(show)
  before_action :logged_in_user, only: %i(new create)

  def index
    @posts = Post.page(params[:page]).per Settings.page
  end

  def show
    @favorite_list_exists = current_user.favorite_lists
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
end
