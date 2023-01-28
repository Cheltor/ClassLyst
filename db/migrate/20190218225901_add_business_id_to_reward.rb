class AddBusinessIdToReward < ActiveRecord::Migration[5.2]
  def change
    add_column :rewards, :business_id, :integer
    add_index :rewards, :business_id
  end
end
