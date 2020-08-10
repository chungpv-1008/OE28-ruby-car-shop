class SetDefaultToPost < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :activated, :boolean, default: false
  end
end
