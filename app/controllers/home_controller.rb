class HomeController < ApplicationController
  def index
    @posts = Post.by_created_at.by_activated.limit(Settings.home_limit)
  end
end
