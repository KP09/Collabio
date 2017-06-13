class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :education, :string
    add_column :users, :profession, :string
  end
end
