class RenameTypeInAddresses < ActiveRecord::Migration[7.1]
  def change
    rename_column :addresses, :type, :address_type

  end
end
