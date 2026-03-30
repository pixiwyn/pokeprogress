class Pokemon < ApplicationRecord
  belongs_to :region
  belongs_to :generation
end
