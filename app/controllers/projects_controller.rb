class ProjectsController < ApplicationController
    before_action :set_project, only: [:show, :edit, :update]
    
    def new 
        if current_user
            @project = Project.new 
            4.times{@project.materials.build}
        else 
            redirect_to root_path
            flash[:notice] = "Please log in to create a project"
        end
    end

    def index
        @projects = Project.all 
    end
    
    def create 
        @project = Project.new(project_params)
        #@project = current_user.projects.build(project_params)
        if @project.save
            redirect_to project_path(@project.id), notice: "Project Successfully Created" 
        else 
            redirect_to new_recipe_path
            flash[:notice] = @recipe.errors.full_messages
            #render :new
        end    
    end
    

    def show 
        if !logged_in?
            redirect_to root_path 
            flash[:notice] = "you must be logged in to see projects"
        end
    end

    private 
    def project_params
        params.require(:project).permit(:name, :user_id, :instructions, materials_attributes_hash: [:name, :id], categories_attributes: [:name], category_ids: [])
    end

    def set_project
        @project = Project.find(params[:id])
    end
    


end
