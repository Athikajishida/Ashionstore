class CreatePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :prices do |t|
      t.references :product, null: false, foreign_key: true
      t.references :color, null: false, foreign_key: true
      t.references :size, null: false, foreign_key: true
      t.decimal :price
      t.integer :quantity

      t.timestamps
    end
  end
end
