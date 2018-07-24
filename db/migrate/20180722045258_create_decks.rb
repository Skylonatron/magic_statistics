class CreateDecks < ActiveRecord::Migration[5.1]
  def change
    create_table :decks do |t|
      t.string :name
      t.integer :match_wins
      t.integer :match_losses
      t.integer :game_wins
      t.integer :game_losses

      t.timestamps
    end
  end
end
