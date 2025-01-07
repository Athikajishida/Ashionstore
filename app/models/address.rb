class Address < ApplicationRecord
  belongs_to :user
  belongs_to :city

  
  validates :house, presence: true
  validates :area, presence: true
  validates :place, presence: true
  validates :pincode, presence: true, 
                     format: { with: /\A\d{6}\z/, message: "should be 6 digits" }
  validates :address_type, presence: true, 
                          inclusion: { in: %w(Home Office Other) }
  validates :city_id, presence: true
  
  # Optional: Add scope for address types
  scope :home_addresses, -> { where(address_type: 'Home') }
  scope :office_addresses, -> { where(address_type: 'Office') }

  def full_address
    "#{house}, #{area}, #{place}, #{city.cityname}, #{pincode}"
  end
end
