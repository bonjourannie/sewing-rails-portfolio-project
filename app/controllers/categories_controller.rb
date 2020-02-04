class CategoriesController < ApplicationController
    before_action :find_category, only: [:show, :edit, :update, :destroy]
    
    def index 
        @categories = Category.all 
        @category = Category.new
        @cateogories_projects = Project.list_by_category
        # binding.pry
    end

    def new 
        @category = Category.new 
    end

    def create 
        @category = Category.new(category_params) 
        if @category.save 
          redirect_to category_path(@category), notice: "Category Successfully Created" 
        else
          render :new 
        end
      end 

    def show 
        @category = Category.find_by(id: params[:id])
        #@project = @category.project_materials
        
    end

    def edit 
    end

    def update 
        if @category.update(category_params)
            redirect_to category_path(@category), notice: "Category Successfully Updated" 
        else 
          render :edit 
        end 
    end 

    def destroy 
        @category.destroy 
        redirect_to categories_path, notice: "Category Successfully Deleted" 
    end

    def sort_by_popularity 
        @catergories = Category.sort_by_popularity 
        @category = Category.new 
        render :index
    end 

    def sort_ABC 
        @catergories = Category.sort_ABC
        @category = Category.new 
        render :index 
    end
    
    private

    def category_params
        params.require(:category).permit(:name)
    end

    def find_category
        @category = Category.find_by(id: params[:id])
    end
    

        
end
