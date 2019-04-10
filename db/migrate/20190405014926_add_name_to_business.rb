class AddNameToBusiness < ActiveRecord::Migration[5.2]
  def change
    add_column :businesses, :name, :string
    add_column :businesses, :code, :string
  end
end
