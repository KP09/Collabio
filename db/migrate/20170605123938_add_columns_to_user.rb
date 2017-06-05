class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :company_name, :string
    add_column :users, :description, :text
    add_column :users, :location, :string
    add_column :users, :company, :boolean
    add_column :users, :admin, :boolean
  end
end
