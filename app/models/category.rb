class Category < ApplicationRecord
    has_many :category_projects
    has_many :projetcs, through: :project_materials
    validates :name, presence: :true 
    validates_uniqueness_of :name 
end
