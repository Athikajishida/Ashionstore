class Product < ApplicationRecord
  has_one_attached :image

  
  
  belongs_to :category
  belongs_to :subcategory
  belongs_to :size
  belongs_to :color
  
end
