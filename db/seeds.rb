# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Coupon.create([
  { code: 'SOCH10NEW', discount_percentage: 10, min_purchase_amount: 2499, expiry_date: '2024-02-29' },
  { code: 'TRYMONROW15', discount_percentage: 15, expiry_date: '2024-04-06' }
])
User.create([{ email: "athikajishida@gmail.com", admin: true, password: "athika123" }])
  

colors_data = [
  { name: "Red" },
  { name: "Blue" },
  { name: "Green" },
  { name: "Brown" },
  { name: "Beige" },
  { name: "Purple" },
  { name: "Yellow" },
  { name: "Orange" },
  { name: "Pink" },
  { name: "Cyan" }
]

# Create colors
colors_data.each do |color_data|
  Color.find_or_create_by(name: color_data[:name])
end
sizes_data = [
  { size: "XS" },
  { size: "S" },
  { size: "M" },
  { size: "L" },
  { size: "XL" },
  { size: "30" },
  { size: "32" },
  { size: "34" },
  { size: "36" },
  { size: "38" }
]

# Create sizes
sizes_data.each do |size_data|
  Size.find_or_create_by(size: size_data[:size])
end