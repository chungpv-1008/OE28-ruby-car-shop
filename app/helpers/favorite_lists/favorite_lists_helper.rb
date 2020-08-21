module FavoriteLists::FavoriteListsHelper
  def favorite_list_text
    if @favorite_list_exists
      t "posts.show.unfavorite"
    else
      t "posts.show.favorite"
    end
  end
end
