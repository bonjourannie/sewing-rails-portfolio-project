class CategoryProject < ApplicationRecord
    has_many :category_projects
    has_many: projects, through :category_recipes

    validates :name, presence: true
    validates_uniqueness_of :name
end
