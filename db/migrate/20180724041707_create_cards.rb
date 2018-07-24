class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :name
      t.integer :magic_id
      t.integer :rarity
      t.string :set
      t.string :collector_number
      t.integer :premium
      

      t.timestamps
    end
  end
end
