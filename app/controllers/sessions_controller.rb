class SessionsController < ApplicationController 
    def new 
    end
    
    def create_with_github
        @user = User.from_omniauth(request.env["omniauth.auth"])

        if @user.persisted?
            sign_in_and_redirect @user, event: :authentication 
            set_flash_message(:notice, :success, kind: "Github") if is_navigational_format?
        else 
            session["devise.github_data"] = request.env["omniauth.auth"]
            render 'new'
        end
      end
    
    
    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to root_url
            flash[:alert] = "Welcome! You are now logged in!"
        else
            flash[:error] = "User not found, please check for misspellings and try again or sign up"
            render 'new'
        end
    end
    
    def destroy
        reset_session
        redirect_to root_url
        flash[:alert] = "Logged out!"
    end
    
    


end
