class V1::GamesController < ApplicationController
  def index
    games = @current_user.games
    render json: games
  end
end
