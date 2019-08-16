class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.references :contestant_one, foreign_key: true
      t.references :contestant_two, foreign_key: true

      t.references :winner, index: true, foreign_key: {to_table: :contestants}
      t.references :round, foreign_key: true

      t.timestamps
    end
  end
end
