class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :score
      t.integer :start_level
      t.integer :finish_level
      t.integer :lines
      t.integer :user_id

      t.timestamps
    end
  end
end
