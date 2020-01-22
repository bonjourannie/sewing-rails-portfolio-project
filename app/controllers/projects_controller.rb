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

    


end
