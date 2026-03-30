class Game < ApplicationRecord
  belongs_to :region
  belongs_to :generation
end
