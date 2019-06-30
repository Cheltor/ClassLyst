class AddDateToReward < ActiveRecord::Migration[5.2]
  def change
    add_column :rewards, :expdate, :date
  end
end
