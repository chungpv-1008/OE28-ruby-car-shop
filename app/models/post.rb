class Post < ApplicationRecord
  POST_PARAMS = [:name, :content, car_attributes: [:year_of_manufacture_id,
    :origin_id, :gearbox_id, :car_type_id, :brand_id, :car_model_id, :color_id,
      :number_of_seat_id, :condition_id, :fuel_id, :image, :price,
        :mileage]].freeze

  belongs_to :user
  has_one :car, dependent: :destroy

  accepts_nested_attributes_for :car, allow_destroy: true

  validates :name, presence: true, length: {maximum: Settings.post.name_length}
  validates :content, presence: true, length:
    {maximum: Settings.post.content_length}
  validates_associated :car

  delegate :name, to: :user, prefix: true
  delegate :image, :year_of_manufacture_name, :gearbox_name, :origin_name,
           :car_type_name, :brand_name, :car_model_name, :color_name,
           :number_of_seat_name, :condition_name, :fuel_name, to: :car,
            prefix: true
end
