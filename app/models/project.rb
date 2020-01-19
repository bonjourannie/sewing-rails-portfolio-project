class Project < ApplicationRecord
    belongs_to :user, :counter_cache => true
    has_many :project_materials 
    has_many :materials, through: :project_materials
    has_many :category_projects
    has_many :categories, through: :category_projects

    validates_presence_of :name, :materials, :instructions
    validates_uniqueness_of :name

    def materials_attributes=(projects_attributes)
        material_name = material_name[:name]
        material = Material.find_or_create_by(name: material_name)
        if !material_name.empty? && material
            self.materials << material unless self.materials.include?(material)
        end 
        self.save
    end

    def categories_attributes=(categories_attributes)
        categories_attributes.values.each do |category_attributes|
            if !categories_attribute[:name].empty? && category = Category.find_or_create_by(categories_attribute)
                self.categories << category 
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
