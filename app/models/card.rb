class Card < ApplicationRecord

  has_many :decks_cards, class_name: "DecksCards", foreign_key: "card_id", dependent: :destroy
  has_many :decks, through: :decks_cards 

  enum rarity: { basic_land: 0, common: 1, uncommon: 2, rare: 3, mythic_rare: 4 }
  enum premium: { no: 0, yes: 1 }

  def image_url
    "https://img.scryfall.com/cards/large/en/#{self.set.downcase}/#{self.collector_number_numerator}.jpg?"
  end

  def collector_number_numerator
    self.collector_number.split('/')[0]
  end



end
