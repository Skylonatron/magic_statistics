class DecksCards < ApplicationRecord
  belongs_to :deck, inverse_of: :decks_cards
  belongs_to :card, inverse_of: :decks_cards
end
