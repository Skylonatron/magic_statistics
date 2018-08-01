module CardsHelper

  def get_full_css_color_name(color)

    return case color
    when 'W' then "#dcdcc6"
    when 'B' then "Black"
    when 'R' then "Red"
    when 'U' then "Blue"
    when 'C' then "Grey"
    when 'G' then "Green"
    end


  end

  def get_full_color_name(color)
    return case color
    when 'W' then "White"
    when 'B' then "Black"
    when 'R' then "Red"
    when 'U' then "Blue"
    when 'C' then "Colorless"
    when 'G' then "Green"
    end
  end

  def get_color_from_set_and_collector_number(collector_number, set=nil)

    color = case
      when collector_number <= 42 then 'W'
      when collector_number <= 84 then 'U'
      when collector_number <= 126 then 'B'
      when collector_number <= 168 then 'R'
      when collector_number <= 210 then 'G'
      when collector_number == 211 then 'WB'
      when collector_number == 212 then 'GWU'
      when collector_number == 213 then 'BR'
      when collector_number == 214 then 'WBU'
      when collector_number == 215 then 'RG'
      when collector_number == 216 then 'RU'

      when collector_number == 217 then 'RW'
      when collector_number == 218 then 'BUR'
      when collector_number == 219 then 'RGW'
      when collector_number == 220 then 'BG'
      when collector_number == 221 then 'BU'
      when collector_number == 222 then 'BW'
      when collector_number == 223 then 'GW'
      when collector_number == 224 then 'GU'
      when collector_number == 225 then 'BRG'
      when collector_number <= 247 then 'C'
      when collector_number >= 247 then 'L'
    end

    return color
  end
end
