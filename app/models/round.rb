class Round < ApplicationRecord
  belongs_to :tournament
  has_many :matches, foreign_key: "round_id", class_name: "Match"
end
