class AddRlimitToRewards < ActiveRecord::Migration[5.2]
  def change
    add_column :rewards, :rlimit, :integer
  end
end
