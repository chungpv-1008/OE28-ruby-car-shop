class Admins::PostsController < AdminsController
  before_action :logged_in_user, only: %i(new create destroy)
  before_action :load_posts, only: :index
  before_action :load_post, only: %i(update edit destroy change_activated)

  def index
    @posts = load_posts.by_created_at.page(params[:page]).per Settings.page_ad
  end

  def show; end

  def new
    @post = Post.new
    @post.build_car
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      flash[:success] = t ".create_success"
      redirect_to admins_posts_path
    else
      flash[:danger] = t ".create_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @post.update post_params
      flash[:success] = t ".update_success"
      redirect_to admins_posts_path
    else
      flash[:danger] = t ".update_fail"
      render "admins/posts/edit"
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_to admins_root_path
  end

  def change_activated
    @post.activated = !@post.activated
    @post.save
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
    redirect_to admins_root_path
  end
end
