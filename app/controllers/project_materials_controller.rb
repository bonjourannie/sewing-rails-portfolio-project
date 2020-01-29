class ProjectMaterialsController < ApplicationController
    before_action :set_project_material, only: [:show, :destroy]

    def index
      @project = Project.find(params[:id])
    end
  
    def new
      @project = Project.find_by(params[:id])
    end
  
    def show
    end
  
    def create
    end
    
    def update
      @project_material = ProjectMaterial.find(params[:id])
      @project = @project_material.project
      @project_material.update(project_material_params)
      
    end
  
    def destroy
      @project_materialt.destroy
      redirect_to project_path(@project_material.project)
    end
  
    private
  
    def set_project_material
      @project_material = ProjectMaterial.find(params[:id])
    end
  
    def project_material_params
      params.require(:project_material).permit(:notes)
    end
end
