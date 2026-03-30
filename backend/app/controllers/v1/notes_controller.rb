class V1::NotesController < ApplicationController
  def show
    note = UserPokemon.find_by(pokemon_id: params[:pokemon_id], user: @current_user)
    render json: note
  end

  def create
    note = UserPokemon.find_or_initialize_by(pokemon_id: params[:pokemon_id], user: @current_user)
    note.note = params["note"]
    note.save
  end
end
