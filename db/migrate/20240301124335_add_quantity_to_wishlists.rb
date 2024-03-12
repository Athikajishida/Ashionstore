class AddQuantityToWishlists < ActiveRecord::Migration[7.1]
  def change
    add_column :wishlists, :quantity, :integer
  end
end
