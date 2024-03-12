class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  belongs_to :cart
  has_many :order_items, dependent: :destroy

end
