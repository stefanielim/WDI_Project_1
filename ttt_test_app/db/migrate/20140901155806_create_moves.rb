class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.references :user
      t.references :game
      t.integer :position
      t.string :marker

      t.timestamps
    end
    add_index :moves, :user_id
    add_index :moves, :game_id
  end
end
