class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :load_commentable, only: %i(new create)
  before_action :load_comment, only: :destroy

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.build comment_params
    if @comment.save
      flash[:success] = t ".comment_success"
    else
      flash[:danger] = t ".comment_failed"
    end
    redirect_back fallback_location: root_path
  end

  def destroy
    if @comment.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_back fallback_location: root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge user_id: current_user.id
  end

  def load_commentable
    @commentable = Comment.find_by(id: params[:comment_id]) ||
                   Post.find_by(id: params[:post_id])
    return if @commentable

    flash[:danger] = t "posts.not_found_post"
    redirect_to fallback_location: root_path
  end

  def load_comment
    @comment = current_user.comments.find_by id: params[:id]
  end
end
