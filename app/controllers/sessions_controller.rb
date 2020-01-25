class SessionsController < ApplicationController 
    def new 
    end

    def create_with_github
        user_info = request.env["omniauth.auth"]
        @user = User.github_login(user_info)
        session[:user_id] = @user.id
        redirect_to root_path
        flash[:alert] = "Welcome! You are now logged in!"
    end
    
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
    
    def auth
        request.env["omniauth.auth"]
    end


end
