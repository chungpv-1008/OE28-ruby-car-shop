class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :address
      t.boolean :admin
      t.string :password_digest
      t.string :remember_digest
      t.boolean :activated
      t.string :reset_digest
      t.datetime :reset_sent_at

      t.timestamps
    end
  end
end
