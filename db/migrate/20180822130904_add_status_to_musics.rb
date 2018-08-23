class AddStatusToMusics < ActiveRecord::Migration[5.0]
  def change
    add_column :musics, :status, :integer
  end
end
