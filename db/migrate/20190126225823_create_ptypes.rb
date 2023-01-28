class CreatePtypes < ActiveRecord::Migration[5.2]
  def change
    create_table :ptypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
