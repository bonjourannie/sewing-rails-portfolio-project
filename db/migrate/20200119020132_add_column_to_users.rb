class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :projects_count, :integer, :default => 0
    User.reset_column_information
    User.all.each do |u|
      User.update_counters u.id, :projects_count => u.projects.length
    end
  end
end
