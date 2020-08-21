class AddIndexToComment < ActiveRecord::Migration[6.0]
  def change
    add_index :comments, :commentable_id
    add_index :comments, :commentable_type
  end
end
