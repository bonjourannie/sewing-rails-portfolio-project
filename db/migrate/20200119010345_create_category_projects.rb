class CreateCategoryProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :category_projects do |t|
      t.integer :category_id
      t.integer :project_id

    end
  end
end
