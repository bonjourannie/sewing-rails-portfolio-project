class AddAmountToProjectMaterials < ActiveRecord::Migration[6.0]
  def change
    add_column :project_materials, :amount, :string
  end
end
