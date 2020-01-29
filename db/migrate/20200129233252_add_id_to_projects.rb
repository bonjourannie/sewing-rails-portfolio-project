class AddIdToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :category_id, :integer
  end
end
