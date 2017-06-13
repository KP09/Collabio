class RemoveBriefFromProjectTable < ActiveRecord::Migration[5.1]
  def change
  	remove_column :projects, :brief
  end
end
