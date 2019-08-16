class CreateContestants < ActiveRecord::Migration[5.2]
  def change
    create_table :contestants do |t|
      t.string :name
      t.references :tournament, foreign_key: true

      t.timestamps
    end
  end
end
