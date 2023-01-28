class AddAddressToBusinesses < ActiveRecord::Migration[5.2]
  def change
    add_column :businesses, :address, :string
  end
end
