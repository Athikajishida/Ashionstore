class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :house
      t.string :area
      t.string :place
      t.string :pincode
      t.string :type, null: false
      t.references :user, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
