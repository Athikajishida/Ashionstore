class Myproduct < ApplicationRecord
  belongs_to :category
  belongs_to :subcategory
  belongs_to :size
  belongs_to :color
end
