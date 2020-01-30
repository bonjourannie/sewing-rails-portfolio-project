class ProjectsController < ApplicationController
    before_action :find_project, only: [:show, :edit, :update]
    
    def new 
        @project = Project.new 
        4.times do 
            @project.project_materials.build.build_material
        end
    end

    def index
        @projects = Project.filter(params[:find_projects_by_name]).desc_listing
        unless @projetcs.present?
          redirect_to projects_path, notice: "Project Not Found"
        end
    end
    
    def create 
        @project = current_user.projects.build(project_params)
        if @project.save
            redirect_to project_path(@project.id), notice: "Project Successfully Created" 
        else 
            redirect_to new_project_path
            flash[:notice] = @project.errors.full_messages
        end    
    end
    

    def show 
        if !current_user.present?
            redirect_to root_path 
            flash[:notice] = "you must be logged in to see projects"
        end
    end

    def edit
        if @project.user == current_user
          5.times{@project.materials.build}
        else
          redirect_to root_path
          flash[:notice] = "You can only edit your own projects."
        end
    end
    
    def update
        @project.update(project_params)
        if @project.save
          redirect_to project_path(@project)
          flash[:notice] = "Project successfully updated"
        else
          render :edit
        end
    end
    
    def most_materials
        project = Project.most_materials
        @project = Project.find(project[0].id)
    end

    private 
    def project_params
        params.require(:project).permit(:name, :user_id, :instructions, materials_attributes: [:name, :id], categories_attributes: [:name], category_ids: [])
    end

    def find_project
        @project = Project.find_by(id: params[:id])
    end
    


end
