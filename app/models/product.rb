class Product < ApplicationRecord
    belongs_to :category
    has_many :prices
    has_many :colors, through: :prices
    has_many :sizes, through: :prices
  
    has_one_attached :image
    
    accepts_nested_attributes_for :prices

    validates :image, presence: true
    validates :colors, presence: true
    validates :sizes, presence: true
  end
  