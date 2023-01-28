class AddDateToRewardpurchase < ActiveRecord::Migration[5.2]
  def change
    add_column :rewardpurchases, :rewardexp, :date
  end
end
