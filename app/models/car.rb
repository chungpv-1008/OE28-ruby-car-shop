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
  validates :price, presence: true,
    numericality: {only_integer:
                   Settings.car.price, greater_than: Settings.car.greater_than,
                   less_than: Settings.car.less_than}
  validates :mileage, presence: true

  delegate :name, to: :year_of_manufacture, prefix: true
  delegate :name, to: :gearbox, prefix: true
  delegate :name, to: :car_type, prefix: true
  delegate :name, to: :car_model, prefix: true
  delegate :name, to: :color, prefix: true
  delegate :name, to: :number_of_seat, prefix: true
  delegate :name, to: :brand, prefix: true
  delegate :name, to: :condition, prefix: true
  delegate :name, to: :fuel, prefix: true
  delegate :name, to: :origin, prefix: true

  mount_uploader :image, ImageUploader
end
