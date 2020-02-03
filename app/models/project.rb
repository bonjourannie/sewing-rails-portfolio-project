class Project < ApplicationRecord
    belongs_to :user, :counter_cache => true
    has_many :project_materials 
    has_many :materials, through: :project_materials
    has_many :category_projects
    has_many :categories, through: :category_projects

    accepts_nested_attributes_for :project_materials, reject_if: :all_blank

    validates_presence_of :name, :instructions
    validates_uniqueness_of :name

    scope :find_projects_by_name, -> (name) { where("name like ?", "#{name.capitalize}%")}

    

    def categories_attributes=(categories_attributes)
        categories_attributes.values.each do |category_attribute|
            if !category_attribute[:name].empty? && category = Category.find_or_create_by(category_attribute)
                self.categories << category
            end
        end
    end



	def self.list_by_category 
		all.group_by(&:category_id)
	end
	
	def self.desc_listing
		all.order(created_at: :desc)
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

    private 

	def name_capitalizer 
		self.name = self.name.capitalize 
	end
end
