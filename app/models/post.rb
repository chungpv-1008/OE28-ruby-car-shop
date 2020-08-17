class Post < ApplicationRecord
  POST_PARAMS = [:name, :content, car_attributes: [:year_of_manufacture_id,
    :origin_id, :gearbox_id, :car_type_id, :brand_id, :car_model_id, :color_id,
    :number_of_seat_id, :condition_id, :fuel_id, :image, :price,
    :mileage]].freeze

  belongs_to :user
  has_one :car, dependent: :destroy
  has_many :favorite_lists, dependent: :destroy

  accepts_nested_attributes_for :car, allow_destroy: true, update_only: true

  validates :name, presence: true, length: {maximum: Settings.post.name_length}
  validates :content, presence: true, length:
    {maximum: Settings.post.content_length}
  validates_associated :car

  scope :by_user_id, ->(user_id){where user_id: user_id}

  scope :by_post_id, ->(post_id){where post_id: post_id}

  scope :by_ids, ->(ids){where id: ids}

  scope :by_year_of_manufacture, (lambda do |year_of_manufacture_ids|
    if year_of_manufacture_ids.present?
      where cars: {year_of_manufacture_id: year_of_manufacture_ids}
    end
  end)

  scope :by_origin, (lambda do |origin_ids|
    where cars: {origin_id: origin_ids} if origin_ids.present?
  end)

  scope :by_gearbox, (lambda do |gearbox_ids|
    where cars: {gearbox_id: gearbox_ids} if gearbox_ids.present?
  end)

  scope :by_car_type, (lambda do |car_type_ids|
    where cars: {car_type_id: car_type_ids} if car_type_ids.present?
  end)

  scope :by_brand, (lambda do |brand_ids|
    where cars: {brand_id: brand_ids} if brand_ids.present?
  end)

  scope :by_car_model, (lambda do |car_model_ids|
    where cars: {car_model_id: car_model_ids} if car_model_ids.present?
  end)

  scope :by_color, (lambda do |color_ids|
    where cars: {color_id: color_ids} if color_ids.present?
  end)

  scope :by_number_of_seat, (lambda do |number_of_seat_ids|
    if number_of_seat_ids.present?
      where cars: {number_of_seat_id: number_of_seat_ids}
    end
  end)

  scope :by_condition, (lambda do |condition_ids|
    where cars: {condition_id: color_ids} if condition_ids.present?
  end)

  scope :by_fuel, (lambda do |fuel_ids|
    where cars: {fuel_id: fuel_ids} if fuel_ids.present?
  end)

  scope :include_car, ->{includes :car}

  delegate :name, to: :user, prefix: true
  delegate :price, :image, :year_of_manufacture_name, :gearbox_name,
           :origin_name, :car_type_name, :brand_name, :car_model_name,
           :color_name, :number_of_seat_name, :condition_name, :fuel_name,
           :mileage, to: :car, prefix: true
end
