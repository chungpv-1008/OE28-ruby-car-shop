class PostsController < ApplicationController
  before_action :logged_in_user, only: %i(show new create)

  def index; end

  def show; end

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
end
