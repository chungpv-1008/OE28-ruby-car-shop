class Car < ApplicationRecord
  belongs_to :year_of_manufacture
  belongs_to :gearbox
  belongs_to :car_type
  belongs_to :car_model
  belongs_to :color
  belongs_to :number_of_seat
  belongs_to :brand
  belongs_to :condition
  belongs_to :fuel
  belongs_to :origin
  belongs_to :post
end
