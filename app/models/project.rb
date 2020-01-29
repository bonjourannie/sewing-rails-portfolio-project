class Project < ApplicationRecord
    belongs_to :user, :counter_cache => true
    has_many :project_materials 
    has_many :materials, through: :project_materials
    has_many :category_projects
    has_many :categories, through: :category_projects

    validates_presence_of :name, :materials, :instructions
    validates_uniqueness_of :name

    def materials_attributes=(material)
        self.material = Materials.find_or_create_by(name: category[:name])
        self.materials.update(material)
    end

    def categories_attributes=(categories_attributes)
        categories_attributes.values.each do |category_attributes|
            if !categories_attribute[:name].empty? && category = Category.find_or_create_by(categories_attribute)
                self.categories.update(categories_attributes) 
            end
        end
    end

    def self.most_materials 
        left_joins(:materials)
        .group(:id)
        .order('COUNT(materials.id) DESC')
        .limit(1)
    end

    def self.search(search)
        joins(:materials).where({materials: {name: "#{search}"}})
    end
end
