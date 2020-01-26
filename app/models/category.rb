class Category < ApplicationRecord
    has_many :category_projects
    has_many :projetcs, through: :project_materials
    validates :name, presence: :true 
    validates_uniqueness_of :name 

    scope :sort_by_popularity, -> { joins(:projects)
    .select("catergories.*", "COUNT(projects.id) AS projects_count")
    .group(:category_id)
    .order("projects_count DESC")
  }
   scope :sort_ABC, -> { order("NAME ASC")}
end
