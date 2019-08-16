class Match < ApplicationRecord
  belongs_to :contestant_one, class_name: "Contestant", :foreign_key => 'contestant_one_id'
  belongs_to :contestant_two, class_name: "Contestant", :foreign_key => 'contestant_two_id'
  belongs_to :winner, class_name: "Contestant", foreign_key: 'winner_id', optional: true
  belongs_to :round, inverse_of: :matches, optional: true
end
