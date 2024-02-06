class AddNameToSubcategories < ActiveRecord::Migration[7.1]
  def change
    add_column :subcategories, :name, :string
  end
end
