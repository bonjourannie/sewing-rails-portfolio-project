class SessionsController < ApplicationController 
    def new 
    end
    
    def create_with_github
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
    
      
      
    #     user_info = request.env["omniauth.auth"]
    #     @user = User.github_login(user_info)
    #     session[:user_id] = @user.id
    #     redirect_to root_path
    #     flash[:alert] = "Welcome! You are now logged in!"
    # end
    
    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to root_url
            flash[:alert] = "Welcome! You are now logged in!"
        else
            flash[:error] = "User not found, please check for misspelling and try again or sign up"
            render 'new'
        end
    end
    
    def destroy
        reset_session
        redirect_to root_url
        flash[:alert] = "Logged out!"
    end
    
    private
    
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


end
