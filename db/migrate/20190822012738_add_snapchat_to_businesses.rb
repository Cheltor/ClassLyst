class AddSnapchatToBusinesses < ActiveRecord::Migration[5.2]
  def change
    add_column :businesses, :snapchat, :string
  end
end
