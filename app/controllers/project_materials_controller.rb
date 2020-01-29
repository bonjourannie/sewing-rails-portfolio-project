class ProjectMaterialsController < ApplicationController
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
        end
    end
    
    def most_materials
        project = Project.most_materials
        @project = Project.find(proejct[0].id)
    end
end
