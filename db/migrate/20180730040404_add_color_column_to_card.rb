class AddColorColumnToCard < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :color, :string
  end
end
