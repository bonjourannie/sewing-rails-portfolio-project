class CategoryProject < ApplicationRecord
    belongs_to :category
    has_many :projects, through: :category_projects

    validates :name, presence: true
    validates_uniqueness_of :name
end
