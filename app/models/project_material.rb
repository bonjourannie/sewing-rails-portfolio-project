class ProjectMaterial < ApplicationRecord
    belongs_to :project 
    belongs_to :material
    validates :amount, presence: true
    validates_uniqueness_of :material_id, scope: :project_id
    

    def material_name
    end 

    def material_name=(material_name)
        self.material = Material.find_or_create_by(name: material_name)
    end

end
