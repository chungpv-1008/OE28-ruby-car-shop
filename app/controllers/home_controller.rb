class HomeController < ApplicationController
  def index
    @posts = Post.by_updated_at.by_activated.limit Settings.home_limit
    @posts_top_favorite = Post.by_favorite_count.this_month
                              .by_activated.limit Settings.home_limit
  end
end
