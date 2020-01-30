class ProjectMaterial < ApplicationRecord
    belongs_to :project 
    belongs_to :material


    def material_name
		self.project_materials.map(&:material_id)
		if material_ids != material_ids.uniq
			self.errors.add(:project_materials, "Material Name Should Appear Once")
		end
	end

    def material_name=(material_name)
        material_name.values.each do |project_material|
            project = Project.find_by(id: project_material[:project_id])
            proj_material = ProjectMaterial.find_by(id: project_material[:id])
            material = Material.find_by(id: project_material[:material_attributes][:id])
            if project && proj_material && material
                proj_material.update(amount: project_material[:amount])
                material.update(name: project_material[:material_attributes][:name])
            else
                self.project_materials.build(project_material)
            end
        end
    end

end
