class CreateMusics < ActiveRecord::Migration[5.0]
  def change
    create_table :musics do |t|
      t.string :title
      t.string :vid
      t.string :length

      t.timestamps
    end
  end
end
