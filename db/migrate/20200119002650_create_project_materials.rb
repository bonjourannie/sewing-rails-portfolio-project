class CreateProjectMaterials < ActiveRecord::Migration[6.0]
  def change
    create_table :project_materials do |t|
      t.integer :project_id
      t.integer :material_id
      t.text :notes

    end
  end
end
