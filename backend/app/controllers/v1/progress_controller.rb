class V1::ProgressController < ApplicationController
  def create
    progress = GameProgress.find_or_initialize_by(game_id: params[:game_id], pokemon_id: params[:pokemon_id], user: @current_user)
    progress.metadata = params[:metadata]
    progress.save
  end

  def show
    progress = GameProgress.where(pokemon_id: params[:pokemon_id], user: @current_user)
    render json: progress
  end
end
