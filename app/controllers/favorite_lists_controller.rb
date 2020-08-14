class FavoriteListsController < ApplicationController
  before_action :logged_in_user, only: %i(index update)

  def index
    favorite_list_post_ids = current_user.favorite_lists.pluck :post_id
    @posts = Post.by_ids(favorite_list_post_ids)
                 .page(params[:page]).per Settings.page
  end

  def show
    redirect_to @post
  end

  def update
    favorite_list = current_user.favorite_lists
                                .find_by post_id: params[:post_id]
    if favorite_list.blank?
      FavoriteList.create post: Post.find_by(id: params[:post_id]),
        user: current_user
      @favorite_list_exists = true
    else
      favorite_list.destroy
      @favorite_list_exists = false
    end
    respond_to do |format|
      format.js
    end
  end
end
