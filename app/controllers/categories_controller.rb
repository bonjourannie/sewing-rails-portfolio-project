class CategoriesController < ApplicationController
    def index 
        @catergories = Catergory.all 
        @catergories = Catergory.new 
    end

    def new 
        @catergory = Category.new 
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

        
end
