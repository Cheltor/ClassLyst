class AddAnonToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :anon_id, :integer, default: 1
  end
end
