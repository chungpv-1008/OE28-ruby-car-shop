class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.references :year_of_manufacture, null: false, foreign_key: true
      t.string :image
      t.integer :price
      t.references :gearbox, null: false, foreign_key: true
      t.references :car_type, null: false, foreign_key: true
      t.references :car_model, null: false, foreign_key: true
      t.references :color, null: false, foreign_key: true
      t.references :number_of_seat, null: false, foreign_key: true
      t.references :brand, null: false, foreign_key: true
      t.references :condition, null: false, foreign_key: true
      t.integer :mileage
      t.references :fuel, null: false, foreign_key: true
      t.references :origin, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
