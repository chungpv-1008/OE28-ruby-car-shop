class Car < ApplicationRecord
  attr_accessor :image

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

  validates :image, presence: true
  validates :price, presence: true, numericality: {only_integer:
    Settings.car.price, greater_than: Settings.car.greater_than,
      less_than: Settings.car.less_than}
  validates :mileage, presence: true

  mount_uploader :image, ImageUploader
end
