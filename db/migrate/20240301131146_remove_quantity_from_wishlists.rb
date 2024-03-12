class RemoveQuantityFromWishlists < ActiveRecord::Migration[7.1]
  def change
    remove_column :wishlists, :quantity, :integer
  end
end
