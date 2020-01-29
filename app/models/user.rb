class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[github]
  has_many :projects 

  #has_secure_password 
  

  # validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  # validates_presence_of :name, :email
  # validates_uniqueness_of :email
  # validates :password, presence: true, :length => {minimum: 6}

  def self.from_omniauth(auth)
    find_or_create_by(email: auth['info']['email']) do |u|
       u.name = auth['info']['name']
       u.email = auth['info']['email']
       u.uid = auth['uid']
       u.provider = auth['provider']
       u.password = SecureRandom.hex(20)
       u.password_confirmation = u.password
       u.save
    end
  end

  def self.most_projects
    User.order("users.projects_count DESC")
  end
    
  def auth
    request.env["omniauth.auth"]
  end

  private 
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


end
