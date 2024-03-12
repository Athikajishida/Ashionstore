class ChangeTotalPriceToDiscountedTotalInOrders < ActiveRecord::Migration[7.1]
  def change
    rename_column :orders, :total_price, :discounted_total

  end
end
