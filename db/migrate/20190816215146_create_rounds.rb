class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.references :tournament, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
