class CreateAnons < ActiveRecord::Migration[5.2]
  def change
    create_table :anons do |t|
      t.string :hide

      t.timestamps
    end
  end
end
