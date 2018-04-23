class AddAddressToEvents < ActiveRecord::Migration[5.1]
  def change
    rename_column :events, :addres, :address
  end
end
