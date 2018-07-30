class DecksController < ApplicationController
  require 'csv'

  before_action :set_deck, only: [:show, :edit, :update, :destroy]

  # GET /decks
  # GET /decks.json
  def index
    @decks = Deck.all
  end

  # GET /decks/1
  # GET /decks/1.json
  def show
    type = params[:type] || 'table'

    @cards = @deck.cards.order('rarity desc')

    if type == 'grid'
      render 'show_grid' and return
    elsif type == 'table'
      render 'show_table' and return
    elsif type == 'data'
      render 'show_data' and return
    else 
      redirect_to root_path and return
    end
  end

  # GET /decks/new
  def new
    @deck = Deck.new
  end

  # GET /decks/1/edit
  def edit
  end

  # POST /decks
  # POST /decks.json
  def create

    file = params[:file]

    deck_info = Deck.create_from_file(file)
    @deck = deck_info[:deck]
    cards = deck_info[:cards]

    @deck.name = params[:name] if params[:name].present?
    @deck.wins = params[:wins] if params[:wins].present?
    @deck.user = current_user

    respond_to do |format|
      if @deck.save!
        @deck.cards << cards
        @deck.save!
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
