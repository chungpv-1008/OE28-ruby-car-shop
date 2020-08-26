class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy

  scope :by_created_at, ->{order created_at: :desc}

  delegate :name, to: :user, prefix: true
end
