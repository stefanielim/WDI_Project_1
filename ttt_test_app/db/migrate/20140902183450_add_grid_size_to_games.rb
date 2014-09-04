class AddGridSizeToGames < ActiveRecord::Migration
  def change
    add_column :games, :grid_size, :integer
  end
end
