class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[github]
  has_many :projects 

  #has_secure_password 
  

  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates_presence_of :name, :email
  validates_uniqueness_of :email
  validates :password, presence: true, :length => {minimum: 6}

  def self.from_omniauth(auth)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication 
      set_flash_message(:notice, :success, kind: "Github") if is_navigational_format?
    else 
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    # user = where(provider: auth.provider, uid: auth.uid).first 
    #   unless user 
    #     user = where(email: auth.info.email).first_or_initialize 
    #     user.email = auth.info.email
    #     user.name = auth.info.name 
    #     user.password = Devise.friendly_token[0,20]
    #     (user.save!(validate: false))
    #   end
    #   user
    end
  end

  def self.most_projects
    User.order("users.projects_count DESC")
  end
    
  def auth
    request.env["omniauth.auth"]
  end


end
