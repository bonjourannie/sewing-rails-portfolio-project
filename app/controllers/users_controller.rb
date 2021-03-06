class UsersController < ApplicationController 
    def new
        @user = User.new 
    end

    def index
        @users = User.all
    end
    
    def create
        @user = User.create(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
            flash[:notice] =  "Thank you for signing up!"
        else
            flash[:error] = @user.errors.full_messages
            render 'new'
        end
    end
    
    def projects
        @user = User.find(params[:user_id])
    end
    
    def show
        @user = User.find(params[:id])
        if @user === current_user
          render :show
        else
          redirect_to "/users/#{@user.id}/projects"
        end
    end
    
    def most_projects
        @users = User.most_projects
    end
    
    
    private
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
