class ChangeDefaultContributions < ActiveRecord::Migration[5.1]
  def change
    change_column :contributions, :starred, :boolean, default: false
  end
end
