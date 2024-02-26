class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :order_id
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.references :address, null: false, foreign_key: true
      t.decimal :total_price
      t.string :payment_method
      t.references :cart, null: false, foreign_key: true

      t.timestamps
    end
  end
end
