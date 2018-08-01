class AddSideboardColumnToDecksCards < ActiveRecord::Migration[5.1]
  def change
    add_column :decks_cards, :sideboard, :integer
  end
end
