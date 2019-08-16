class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :destroy, :generate_first_round, :generate_next_round]

  # GET /tournaments
  # GET /tournaments.json
  def index
    @tournaments = Tournament.all
  end

  def generate_first_round
    n = @tournament.contestants.count
    contestants = @tournament.contestants.shuffle
    if is_pow_2(n)
      Round.create!(
        number: 1,
        tournament: @tournament,
        matches: (1..(n/2)).map{|i| Match.new(contestant_one: contestants[i - 1], contestant_two: contestants[n - i])}
      )
    else
      free_pass = 0
      while !is_pow_2(n + free_pass)
        free_pass += 1
      end
      n = n - free_pass
      matches = (1..(n/2)).map{|i| Match.new(contestant_one: contestants[i - 1], contestant_two: contestants[n - i])}
      (1..free_pass).each do |i|
        matches.push(Match.new(
          contestant_one: contestants[n + i - 1],
          contestant_two: contestants[n + i - 1],
          winner: contestants[n + i - 1]))
      end
      Round.create!(
          number: 1,
          tournament: @tournament,
          matches: matches
      )
    end
    redirect_to @tournament
  end

  def generate_next_round
    matches = @tournament.rounds.last.matches
    n = matches.count
    round = Round.new(
      number: @tournament.rounds.last.number + 1,
      tournament: @tournament,
      matches: (1..(n/2)).map{|i| Match.new(contestant_one: matches[i - 1].winner, contestant_two: matches[n - i].winner)}
    )
    if round.save
      redirect_to @tournament
    else
      redirect_to @tournament, alert: "Not all matches have ended"
    end
  end

  # GET /tournaments/1
  # GET /tournaments/1.json
  def show
  end

  # GET /tournaments/new
  def new
    @tournament = Tournament.new
  end

  # GET /tournaments/1/edit
  def edit
  end

  # POST /tournaments
  # POST /tournaments.json
  def create
    @tournament = Tournament.new(tournament_params)

    respond_to do |format|
      if @tournament.save
        format.html { redirect_to @tournament, notice: 'Tournament was successfully created.' }
        format.json { render :show, status: :created, location: @tournament }
      else
        format.html { render :new }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tournaments/1
  # PATCH/PUT /tournaments/1.json
  def update
    respond_to do |format|
      if @tournament.update(tournament_params)
        format.html { redirect_to @tournament, notice: 'Tournament was successfully updated.' }
        format.json { render :show, status: :ok, location: @tournament }
      else
        format.html { render :edit }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournaments/1
  # DELETE /tournaments/1.json
  def destroy
    @tournament.destroy
    respond_to do |format|
      format.html { redirect_to tournaments_url, notice: 'Tournament was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def is_pow_2(n)
      n.to_s(2).count('1') == 1
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tournament_params
      params.require(:tournament).permit(:title, contestants_attributes: [:id, :name, :_destroy])
    end
end
