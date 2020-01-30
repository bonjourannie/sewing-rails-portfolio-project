class ProjectsController < ApplicationController
    before_action :find_project, only: [:show, :edit, :update]
    
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
        if params[:search]
            @projects = Project.search(params[:search]) 
        else 
            @projects = Project.all
        end 
    end
    
    def create 
        #@project = Project.new(project_params)
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
          render :show
        else
          render :edit
          # flash[:notice] = "There is an error here."
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
        @project = Project.find(params[:id])
    end
    


end
