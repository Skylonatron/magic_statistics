class Deck < ApplicationRecord
  include CardsHelper

  validates :name, presence: true

  has_many :decks_cards, class_name: "DecksCards", foreign_key: "deck_id", dependent: :destroy
  has_many :cards, through: :decks_cards 
  belongs_to :user


  def cards_with_sideboard
    self.cards.select("cards.*, decks_cards.sideboard")
  end

  def get_colors
    color_hash = self.cards.mainboard.group(:color).count.sort_by(&:last).reverse.to_h
    color_hash.delete("C")
    color_hash.delete("L")

    colors_array = color_hash.keys.flat_map do |c|
      if c.length > 1
        c.split('')
      else
        c
      end
    end

    colors_array.uniq


  end

  def get_pie_chart_data
    color_hash = self.cards.mainboard.group(:color).count.sort_by(&:last).reverse.to_h
    color_hash.delete("L")

    color_hash.each do |key, value|
      multicolor = []
      if key.length > 1
        color_hash.delete(key)
        key.split('').each do |letter|
          if color_hash[letter]
            color_hash[letter] += 1
          # else
          #   color_hash[letter] = 1
          end
        end
      end
    end

    chart_data = color_hash.map do |key, value|
      [get_full_color_name(key), value]
    end

    color_data = color_hash.map do |key, value|
      get_full_css_color_name(key)
    end

    { colors: color_data, chart_data: chart_data }

  end


  def self.create_from_file(file, name: nil)

    d = Deck.new(name: file.original_filename)
    cards = []



    CSV.foreach(file.path, headers: true) do |row|

      # collecting win loss data from the first row
      if $. == 2
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
      sideboard = row[7]

      card = Card.find_or_create_by(
        name: name,
        magic_id: magic_id,
        rarity: rarity.parameterize.underscore,
        set: set,
        collector_number: collector_number,
        premium: premium.parameterize
      )

      d.decks_cards.new(card: card, sideboard: sideboard.downcase)


    end

    return d

  end
end









