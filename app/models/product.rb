class Product < ApplicationRecord
  has_one_attached :image

  has_many :variants, class_name: 'Price', dependent: :destroy
  accepts_nested_attributes_for :variants, allow_destroy: true 
  
  belongs_to :category
  belongs_to :subcategory
  belongs_to :size
  belongs_to :color
  
end
