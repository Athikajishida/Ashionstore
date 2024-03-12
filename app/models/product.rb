class Product < ApplicationRecord
  has_one_attached :image

  has_many :variants, class_name: 'Price', dependent: :destroy
  accepts_nested_attributes_for :variants, allow_destroy: true 
  has_many :cart_items, dependent: :destroy

  belongs_to :category
  belongs_to :subcategory
  belongs_to :size
  belongs_to :color
  has_many :order_items

  def price
    variants.first&.price
  end

  def reduce_quantity(quantity)
    update_columns(quantity_available: quantity_available - quantity)
  end
end
