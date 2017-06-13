class AddExtraFormFieldsToNewProject < ActiveRecord::Migration[5.1]
  def change
  	add_column :projects, :goal, :string
  	add_column :projects, :what_company_looking_for, :string
  	add_column :projects, :benefit_to_candidate, :string
  end
end
