class ProjectsController < ApplicationController
    before_action :set_project, only: [:show, :edit, :update]
    
    def new 
        if current_user
            @project = current_user.projects.build
            4.times{@project.materials.build}
        else 
            refirect_to root_path
            flash[:notice] = "Please log in to create a project"
        end
    end

    def index
        @projects = Project.all 
    end
    
    def create 
        @project = Project.new(project_params)
        if project.save
            refirect_to @project
            flash[:notice] = "your project was successfully created"
        else 
            refirect_to new_project_path 
            flash[:notice] = @project.errors.full_message
        end
    end

    private 
    def project_params
        params.require(:project).permit(:name, :user_id, :instructions, materials_attributes: [:name, :id], categories_attributes: [:name], category_ids: [])
    end

    def set_project
        @project = Project.find(params[:id])
      end
    


end
