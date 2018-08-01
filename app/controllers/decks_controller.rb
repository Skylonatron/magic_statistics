class DecksController < ApplicationController
  require 'csv'

  before_action :set_deck, only: [:show, :edit, :update, :destroy]

  # GET /decks
  # GET /decks.json
  def index
    @title = "All Decks"
    @home_path = decks_path
    @items = [{ name: "New", path: new_deck_path }]

    @decks = Deck.all
  end

  def user_index
    @user = User.find(params[:user_id])
    @title = "Account Home"
    @home_path = user_path(@user)
    @items = [{ name: "My Decks", path: user_decks_path(@user) }]

    @decks = @user.decks

    render 'index'
  end

  # GET /decks/1
  # GET /decks/1.json
  def show
    @title = "All Decks"
    @home_path = decks_path
    @items = [{ name: "New", path: new_deck_path }, { name: @deck.name, path: deck_path(@deck)}]

    type = params[:type] || 'table'

    if type == 'grid'
      @cards = @deck.cards.mainboard.order('rarity desc, color')
      render 'show_grid' and return
    elsif type == 'table'
      @cards = @deck.cards_with_sideboard.order('decks_cards.sideboard, rarity desc, color')
      render 'show_table' and return
    elsif type == 'data'
      @cards = @deck.cards_with_sideboard
      @deck_chart_data = @deck.cards.mainboard.get_color_pie_chart_data
      render 'show_data' and return
    else 
      redirect_to root_path and return
    end
  end

  # GET /decks/new
  def new
    @title = "All Decks"
    @home_path = decks_path
    @items = [{ name: "New", path: new_deck_path }]

    @deck = Deck.new
  end

  # GET /decks/1/edit
  def edit
  end

  # POST /decks
  # POST /decks.json
  def create
    @title = "Decks"
    @home_path = decks_path

    @items = [{ name: "New", path: new_deck_path }]

    file = params[:file]

    @deck = Deck.create_from_file(file)

    @deck.name = params[:name] if params[:name].present?
    @deck.wins = params[:wins] if params[:wins].present?
    @deck.user = current_user if current_user

    respond_to do |format|
      if @deck.save!
        format.html { redirect_to new_deck_path, notice: 'Deck was successfully created.' }
        format.json { render :show, status: :created, location: @deck }
      else
        format.html { render :new }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /decks/1
  # PATCH/PUT /decks/1.json
  def update
    respond_to do |format|
      if @deck.update(deck_params)
        format.html { redirect_to @deck, notice: 'Deck was successfully updated.' }
        format.json { render :show, status: :ok, location: @deck }
      else
        format.html { render :edit }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /decks/1
  # DELETE /decks/1.json
  def destroy
    @deck.destroy
    respond_to do |format|
      format.html { redirect_to decks_url, notice: 'Deck was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deck
      @deck = Deck.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deck_params
      params.fetch(:deck, :name, :wins)
    end
end
