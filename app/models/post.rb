class Post < ApplicationRecord
  POST_PARAMS = [:name, :content, car_attributes: [:year_of_manufacture_id,
    :origin_id, :gearbox_id, :car_type_id, :brand_id, :car_model_id, :color_id,
      :number_of_seat_id, :condition_id, :fuel_id, :image, :price, :mileage]]

  belongs_to :user
  has_one :car, dependent: :destroy

  accepts_nested_attributes_for :car, allow_destroy: true

  validates :name, presence: true, length: {maximum: Settings.post.name_length}
  validates :content, presence: true, length:
    {maximum: Settings.post.content_length}
  validates_associated :car
end
