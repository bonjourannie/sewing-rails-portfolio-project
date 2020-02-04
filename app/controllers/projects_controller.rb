class ProjectsController < ApplicationController
    before_action :find_project, only: [:show, :edit, :update]
    
    def new 
        @project = Project.new 
        4.times do 
            @project.project_materials.build
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
        @project = current_user.projects.build(project_params)
        if @project.save
            #binding.pry
            redirect_to project_path(@project.id), notice: "Project Successfully Created" 
        else 
            flash[:notice] = @project.errors.full_messages
            render :new
        end    
    end
    

    def show
        redirect_to projects_path, notice: "Record not found" if @project.nil?
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
        params.require(:project).permit(:name, :instructions, :categories_attributes => [:name], :category_ids => [], :project_materials_attributes => [:material_name, :project_id, :amount])
    end 

    def find_project
        @project = Project.find_by(id: params[:id])
    end
    


end
