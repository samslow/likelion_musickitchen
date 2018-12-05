class AddColsToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :applicant, :string
    add_column :messages, :state, :integer
  end
end
