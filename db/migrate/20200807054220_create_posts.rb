class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.string :content
      t.boolean :activated

      t.timestamps
    end
  end
end
