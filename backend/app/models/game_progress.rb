class GameProgress < ApplicationRecord
  belongs_to :user
  belongs_to :pokemon
  belongs_to :game
end
