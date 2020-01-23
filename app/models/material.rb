class Material < ApplicationRecord
  has_many :project_materials 
  has_many :projects, through: :project_materials 
  validates :name, presence: true, uniqueness: true

  scope :sort_by_popularity, -> { joins(:projects)
    .select("projects.*", "COUNT(projects.id) AS projects_count")
    .group(:material_id)
    .order("projects_count DESC")
  }

  scope :sort_ABC, -> { order("NAME ASC")}
end
