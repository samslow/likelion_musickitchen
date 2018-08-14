class AddDurationToMusic < ActiveRecord::Migration[5.0]
  def change
    add_column :musics, :duration, :integer
  end
end
