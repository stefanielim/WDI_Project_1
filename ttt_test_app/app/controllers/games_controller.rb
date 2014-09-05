class GamesController < ApplicationController
  
  load_and_authorize_resource :move, except: [:index]
  # GET /games
  # GET /games.json
  def index
    @games = Game.all
    @player_games = current_user.games rescue nil
    @ongoing_games = Game.where(outcome: 'In progress').all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])
    @moves = @game.moves

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  def make_move
    @move = Move.new
    @game = Game.find(params[:id])
    @move.position = params[:position]
    @move.game = @game
    @move.user_id = current_user.id
    @moves = @game.moves


    respond_to do |format|
      if @move.save
        format.html { redirect_to @game, notice: 'Move was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "show" }
        format.json { render json: @move.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new
    @game.player_1_id = current_user.id
 
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(params[:game])
    @game.player_1_id = current_user.id

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end
end
