class AddColorToProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :color, null: false, foreign_key: true
  end
end
