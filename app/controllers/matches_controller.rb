class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :edit, :update, :destroy]

  # PATCH/PUT /rounds/1
  # PATCH/PUT /rounds/1.json
  def update
    respond_to do |format|
      if @match.update(matches_params)
        format.html { redirect_to @match.round.tournament, notice: 'Matches have been updated.' }
        format.json { render :show, status: :ok, location: @match.round.tournament }
      else
        format.html { render :edit }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def matches_params
      params.require(:match).permit(:winner_id)
    end

    def set_match
      @match = Match.find(params[:id])
    end
end
