class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :course, foreign_key: true
      t.references :ptype, foreign_key: true
      t.string :title
      t.string :url
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
