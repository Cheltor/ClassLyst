class AddByeToReward < ActiveRecord::Migration[5.2]
  def change
  	 add_column :rewards, :byed, :boolean, default: false
  end
end
