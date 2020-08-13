class FavoriteList < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :by_user_id, ->(user_id){where user_id: user_id}
  scope :by_post_id, ->(post_id){where post_id: post_id}
end
