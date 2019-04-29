class AddSocialToBusinesses < ActiveRecord::Migration[5.2]
  def change
    add_column :businesses, :website, :string
    add_column :businesses, :facebook, :string
    add_column :businesses, :twitter, :string
    add_column :businesses, :instagram, :string
  end
end
