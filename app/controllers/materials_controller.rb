class MaterialsController < ApplicationController

    def index 
        @materials = Material.all 
    end

    def show 
        @material = Material.find(params[:id])
    end

    def sort_by_popularity 
        @materials = Material.sort_by_popularity
        # render :index 
    end

    def sort_ABC 
        @materials = Material.sort_ABC 
        # render :index 
    end


end
