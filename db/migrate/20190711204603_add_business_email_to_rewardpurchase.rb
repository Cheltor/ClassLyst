class AddBusinessEmailToRewardpurchase < ActiveRecord::Migration[5.2]
  def change
    add_column :rewardpurchases, :bizemail, :string
  end
end
