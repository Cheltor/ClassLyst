class AddHiddenToComment < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :hidden, :boolean, default: false
  end
end
