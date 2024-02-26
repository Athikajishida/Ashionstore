class CreateCoupons < ActiveRecord::Migration[7.1]
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :discount_percentage
      t.integer :min_purchase_amount
      t.integer :max_discount_amount
      t.date :expiry_date

      t.timestamps
    end
  end
end
