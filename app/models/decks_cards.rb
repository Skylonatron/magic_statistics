class DecksCards < ApplicationRecord
  belongs_to :deck, optional: true
  belongs_to :card

  enum sideboard: { no: 0, yes: 1 }
end
