class CreateNews < ActiveRecord::Migration[6.0]
  def change
    create_table :news do |t|
      t.string :name
      t.string :image
      t.string :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
