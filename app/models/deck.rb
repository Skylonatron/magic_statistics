class Deck < ApplicationRecord

  has_many :decks_cards, class_name: "DecksCards", foreign_key: "deck_id", dependent: :destroy
  has_many :cards, through: :decks_cards 
  belongs_to :user

  accepts_nested_attributes_for :decks_cards, :cards

  def get_colors
    color_hash = self.cards.group(:color).count.sort_by(&:last).reverse.to_h
    color_hash.delete("C")
    color_hash.delete("L")

    # hack to only show so many colors, change to only look at mainboard
    color_hash.reject! { |key, value| value < 4 }

    return color_hash.keys

  end

  def self.create_from_file(file, name: nil)

    d = Deck.new(name: file.original_filename)
    cards = []

    CSV.foreach(file.path, headers: true) do |row|

      if $. == 2
        sideboard = row[7]
        match_wins = row[8]
        match_losses = row[9]
        game_wins = row[10]
        game_losses = row[11]

        if match_wins.present?
          d.match_wins = match_wins
          d.match_losses = match_losses
          d.game_wins = game_wins
          d.game_losses = game_losses
        end
      end

      name = row[0]

      next unless name.present?

      quantity = row[1]
      magic_id = row[2]
      rarity = row[3]
      set = row[4]
      collector_number = row[5]
      premium = row[6]

      card = Card.find_or_create_by(
        name: name,
        magic_id: magic_id,
        rarity: rarity.parameterize.underscore,
        set: set,
        collector_number: collector_number,
        premium: premium.parameterize()
      )

      cards << card

    end

    return { deck: d, cards: cards }

  end
end









