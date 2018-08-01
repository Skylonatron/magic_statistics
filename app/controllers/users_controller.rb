class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @title = "Account Home"
    @home_path = user_path(@user)
    @items = [{ name: "My Decks", path: user_decks_path(@user) }]
    @user_chart_data = @user.cards.mainboard.get_color_pie_chart_data
  end

end
