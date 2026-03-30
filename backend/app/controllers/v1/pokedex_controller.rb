class V1::PokedexController < ApplicationController
  def index
    pokemon = Pokemon.order(:pokedex_number).limit(params[:limit] || 25).offset(params[:offset] || 0)
    render json: pokemon
  end
end
