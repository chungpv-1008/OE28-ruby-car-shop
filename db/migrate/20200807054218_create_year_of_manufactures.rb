class CreateYearOfManufactures < ActiveRecord::Migration[6.0]
  def change
    create_table :year_of_manufactures do |t|
      t.string :name

      t.timestamps
    end
  end
end
