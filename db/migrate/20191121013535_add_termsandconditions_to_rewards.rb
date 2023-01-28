class AddTermsandconditionsToRewards < ActiveRecord::Migration[5.2]
  def change
    add_column :rewards, :Termsandconditions, :string
  end
end
