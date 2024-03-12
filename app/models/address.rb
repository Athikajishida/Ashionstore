class Address < ApplicationRecord
  belongs_to :user
  belongs_to :city

  def full_address
    "#{house}, #{area}, #{place}, #{city.cityname}, #{pincode}"
  end
end
