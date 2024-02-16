class Price < ApplicationRecord
  belongs_to :product
  belongs_to :color
  belongs_to :size

  validates :price, presence: true
  validates :quantity, presence: true
end
