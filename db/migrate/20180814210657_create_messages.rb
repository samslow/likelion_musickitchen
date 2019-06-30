class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.string :applicant
      t.integer :state

      t.timestamps
    end
  end
end
