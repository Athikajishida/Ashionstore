class Price < ApplicationRecord
  belongs_to :product
  belongs_to :color
  belongs_to :size

  validates :price, presence: true
  validates :quantity, presence: true
  def self.current_price(product, options = {})
  # Implement logic to fetch the current price based on options (e.g., color, size)
  # This can be done based on your business rules
  # For simplicity, assuming there is only one price per product for now
  product.prices.first&.amount || 0
end
end
