class Project < ApplicationRecord
    belongs_to :user, :counter_cache => true
    has_many :project_materials 
    has_many :materials, through: :project_materials
    has_many :category_projects
    has_many :categories, through: :category_projects

    validates_presence_of :name, :materials, :instructions
    validates_uniqueness_of :name
end
