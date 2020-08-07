class CreateNumberOfSeats < ActiveRecord::Migration[6.0]
  def change
    create_table :number_of_seats do |t|
      t.string :name

      t.timestamps
    end
  end
end
