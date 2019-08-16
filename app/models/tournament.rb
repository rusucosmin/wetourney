class Tournament < ApplicationRecord
  has_many :contestants, inverse_of: :tournament
  accepts_nested_attributes_for :contestants, reject_if: :all_blank, allow_destroy: true

  has_many :rounds
end
