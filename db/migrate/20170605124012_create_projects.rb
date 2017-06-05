class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :brief
      t.datetime :end_date
      t.integer :max_participations
      t.string :category
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
