class UsersController < ApplicationController

  def show
    @user_chart_data = current_user.cards.mainboard.get_color_pie_chart_data
  end

end
